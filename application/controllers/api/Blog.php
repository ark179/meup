<?php

defined('BASEPATH') OR exit('No direct script access allowed');


// This can be removed if you use __autoload() in config.php OR use Modular Extensions
/** @noinspection PhpIncludeInspection */
require APPPATH . 'libraries/REST_Controller.php';
require_once('vendor/autoload.php');

/**
 * This is an example of a few basic user interaction methods you could use
 * all done with a hardcoded array
 *
 * @package         CodeIgniter
 * @subpackage      Rest Server
 * @category        Controller
 * @author          Phil Sturgeon, Chris Kacerguis
 * @license         MIT
 * @link            https://github.com/chriskacerguis/codeigniter-restserver
 */
class Blog extends REST_Controller {

    function __construct() {
        // Construct the parent class
        parent::__construct();
        $this->load->model('api/blog_model');
        $this->load->model('api/user_model');
    }

    protected function middleware() {
        return array('auth|only:blog_list');
    }
    public function blog_list_post() {
        ini_set('display_errors', 1);
        error_reporting(E_ALL);
        $request_data = $this->_post_args;
        $response = array();
        $blog_info = NULL;
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('user_id', 'User Id', 'required', array('required' => 'Please enter  %s .'));

        if ($this->form_validation->run() == TRUE) {
            $page_index = isset($request_data["page_index"]) ? $request_data["page_index"] : 1;
            empty($request_data['blog_id']) ?$blog_id='': $blog_id = $request_data['blog_id'];
            $user_exists = $this->user_model->findUserById($request_data['user_id']);
            if ($user_exists != FALSE) {        
            $blogs = $this->blog_model->getBlogListWithPagination($page_index,$blog_id);
             if(!empty($blogs['data'])){
                foreach($blogs['data'] as $blog){
                    $blog->blog_image=(empty($blog->blog_image)? "" : $blog->blog_image=base_url('assets/uploads/blogs/').$blog->blog_id.'/'.$blog->blog_image); 
                    $blog->blog_thumb_image=(empty($blog->blog_thumb_image)? "" : $blog->blog_thumb_image=base_url('assets/uploads/blogs/').$blog->blog_id.'/thumb/'.$blog->blog_thumb_image); 
                }
                $response['message'] = 'success';
             }
             else
                 $response['message'] = 'No more data found';
             
                    //$response['message'] = 'success';
                    $response['code'] = parent::HTTP_OK;
                    $response['status'] = true;
                    $response['per_page'] =  $blogs['page']['per_page'];
                    $response['curr_page'] = $blogs['page']['curr_page'];
                    $response['prev_page'] = $blogs['page']['prev_page'];
                    $response['next_page'] = $blogs['page']['next_page'];
                    $response['count'] = $blogs['page']['count'];
                    unset($blogs['page']);
                    $response['data'] = $blogs['data'];
            }
            else {
                $response['message'] = 'Invalid User Id';
                $response['code'] = parent::HTTP_OK;
                $response['data'] = array();
                $response['status'] = false;
            }
                
        } else {
            $response['data'] = array();
            $response['code'] = parent::HTTP_BAD_REQUEST;
            $response['status'] = false;
            $response['message'] = validation_errors();
            
        }
        $this->response($response, $response['code']);
    }
    

}
