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
class Background_image extends REST_Controller {

    function __construct() {
        // Construct the parent class
        parent::__construct();
        $this->load->model('api/user_model');
    }

    protected function middleware() {
        return array('auth|only:');
    }

    public function background_image_post() {
        ini_set('display_errors', 1);
        error_reporting(E_ALL);
        $response = array();
        $background_image_info = Array();
        $background_image_info = $this->user_model->getBackgroundImage();
        if(!empty($background_image_info)){
            foreach($background_image_info as $background_image){
                    $background_image->image=(empty($background_image->image)? "" : $background_image->image=base_url('assets/uploads/background_images/').$background_image->background_image_master_id.'/'.$background_image->image); 
                    //$background_image->vThumbImage=(empty($background_image->vThumbImage)? "" : base_url('assets/uploads/sport_values/').$background_image->iBackgroundImageMaster.'/'.$background_image->vThumbImage); 
            }
            $response['message'] = 'Success';
            $response['code'] = parent::HTTP_OK;
            $response['status'] = true;
            $response['data'] = $background_image_info;
        }
        else{
            $response['message'] = 'No data found';
            $response['code'] = parent::HTTP_OK;
            $response['status'] = false;
            $response['data'] = [];
        }
            
            
        $this->response($response, $response['code']);
    }
}
