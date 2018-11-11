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
class Gym extends REST_Controller {

    function __construct() {
        // Construct the parent class
        parent::__construct();
        $this->load->model('api/gym_model');
    }

    protected function middleware() {
        return array('auth|only:gym_list');
    }
    public function gym_list_post() {
        ini_set('display_errors', 1);
        error_reporting(E_ALL);
        $request_data = $this->_post_args;
        $response = array();
        $gym_info = NULL;
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('user_id', 'User Id', 'required', array('required' => 'Please enter  %s .'));

        if ($this->form_validation->run() == TRUE) {
            $page_index = isset($request_data["page_index"]) ? $request_data["page_index"] : 1;
            empty($request_data['gym_master_id']) ?$gym_id='': $gym_id = $request_data['gym_master_id'];
            $selectFields="vLatitude AS latitude,vLongitude AS longitude";
            $user_data = $this->user_model->getUserSelectedData($selectFields,$request_data['user_id']);
            if (!empty($user_data)) {        
            $gyms = $this->gym_model->getGymListWithPagination($page_index,$gym_id);
            if(!empty($gyms['data'])){
                foreach($gyms['data'] as $gym){
                    $gym->gym_image=(empty($gym->gym_image)? "" : $gym->gym_image=base_url('assets/uploads/gyms/').$gym->gym_master_id.'/'.$gym->gym_image); 
                    $gym->gym_thumb_image=(empty($gym->gym_thumb_image)? "" : $gym->gym_thumb_image=base_url('assets/uploads/gyms/').$gym->gym_master_id.'/thumb/'.$gym->gym_thumb_image); 
                    $user_data->latitude=empty($user_data->latitude)? 0 : $user_data->latitude;
                    $user_data->longitude=empty($user_data->longitude)? 0 : $user_data->longitude;
                    if(isset($request_data['latitude']) && isset($request_data['latitude']) && $request_data['latitude']!=''&& $request_data['longitude']!='')
                        $gym->distance=(int)$this->distance($request_data['latitude'],$request_data['longitude'],$gym->latitude,$gym->longitude,"K");
                    else
                        $gym->distance=(int)$this->distance($user_data->latitude,$user_data->longitude,$gym->latitude,$gym->longitude,"K");
                
                    
                }
                 $response['message'] = 'success';
             }
             else
                 $response['message'] = 'No more data found';
             
                    $response['code'] = parent::HTTP_OK;
                    $response['status'] = true;
                    $response['per_page'] =  $gyms['page']['per_page'];
                    $response['curr_page'] = $gyms['page']['curr_page'];
                    $response['prev_page'] = $gyms['page']['prev_page'];
                    $response['next_page'] = $gyms['page']['next_page'];
                    $response['count'] = $gyms['page']['count'];
                    unset($gyms['page']);
                    $response['data'] = $gyms['data'];
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
    function distance($lat1=0, $lon1=0, $lat2=0, $lon2=0, $unit) {

        $theta = $lon1 - $lon2;
        $dist = sin(deg2rad($lat1)) * sin(deg2rad($lat2)) + cos(deg2rad($lat1)) * cos(deg2rad($lat2)) * cos(deg2rad($theta));
        $dist = acos($dist);
        $dist = rad2deg($dist);
        $miles = $dist * 60 * 1.1515;
        $unit = strtoupper($unit);

        if ($unit == "K") {
            return ($miles * 1.609344);
        } else if ($unit == "N") {
            return ($miles * 0.8684);
        } else {
            return $miles;
        }
    }

}
