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
class Sport extends REST_Controller {

    function __construct() {
        // Construct the parent class
        parent::__construct();
        $this->load->model('api/sport_model');
    }

    protected function middleware() {
        return array('auth|only:');
    }

    public function sport_value_post() {
        ini_set('display_errors', 1);
        error_reporting(E_ALL);
        $response = array();
        $sport_value_info = Array();
        $sport_value_info = $this->sport_model->getSportValue();
        if(!empty($sport_value_info)){
            foreach($sport_value_info as $sport_value){
                    $sport_value->icon=(empty($sport_value->icon)? "" : base_url('assets/uploads/sport_values/').$sport_value->sport_value_master_id.'/xxh/'.$sport_value->icon); 
                    $sport_value->active_icon=(empty($sport_value->active_icon)? "" : base_url('assets/uploads/sport_values/').$sport_value->sport_value_master_id.'/xxh/'.$sport_value->active_icon); 
            }
            $response['message'] = 'Success';
            $response['code'] = parent::HTTP_OK;
            $response['status'] = true;
            $response['data'] = $sport_value_info;
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
