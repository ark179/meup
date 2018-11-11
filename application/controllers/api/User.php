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
class User extends REST_Controller {

    function __construct() {
        // Construct the parent class
        parent::__construct();
        $this->load->model('api/user_model');
        $this->load->model('api/blog_model');
        $this->load->model('api/gym_model');
        $this->load->model('api/sport_model');
    }

    protected function middleware() {
        return array('auth|only:change_password,update_user,change_email,main_feed_details,get_profile_data');
    }

    public function login_post() {
        ini_set('display_errors', 1);
        error_reporting(E_ALL);
        $request_data = $this->_post_args;
        $response = array();
        $user_info = NULL;
        $auth_token = NULL;
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('email', 'Email', 'required', array('required' => 'Please enter  %s .'));
        $this->form_validation->set_rules('password', 'Password', 'required', array('required' => 'Please enter %s .'));

        if ($this->form_validation->run() == TRUE) {
            $data = array(
                'email' => $request_data['email']
            );
            $user_info = $this->user_model->user_login($data);
            
            if ($user_info != NULL) {
                empty($user_info->profile_pic) ? (empty($user_info->fb_profile_pic) ? $user_info->profile_pic="" : $user_info->profile_pic=$user_info->fb_profile_pic) : $user_info->profile_pic=base_url('assets/uploads/users/profile_images/').$user_info->user_id.'/'.$user_info->profile_pic;
            unset($user_info->fb_profile_pic);
                if (password_verify($request_data['password'], $user_info->password)) {
                    unset($user_info->password);

                    $auth_token = generateAuthToken($user_info->user_id);
                    $user_info->access_token = $auth_token;
                     $update_data = array(
                            'vAccessToken' => $user_info->access_token,
                            'iUsersId'=>$user_info->user_id
                        );
                     $this->user_model->user_device_update($update_data);
                     
                    $response['message'] = 'Authentication successful';
                    $response['code'] = parent::HTTP_OK;
                    $response['data'] = [$user_info];
                    $response['status'] = true;
                } else {
                    $response['message'] = 'Incorrect E-Mail ID/Username or Password.';
                    $response['code'] = parent::HTTP_OK;
                    $response['data'] = array();
                    $response['status'] = false;
                }
            } else {
                $response['message'] = 'Incorrect E-Mail ID/Username or Password.';
                $response['code'] = parent::HTTP_OK;
                $response['data'] = array();
                $response['status'] = false;
            }
        } else {
            $response['data'] = array();
            $response['code'] = parent::HTTP_BAD_REQUEST;
            $response['message'] = validation_errors();
            $response['status'] = false;
        }

        $this->response($response, $response['code']);
    }
    public function update_user_post() {
        ini_set('display_errors', 1);
        error_reporting(E_ALL);
        $request_data = $this->_post_args;
        $response = array();
        $user_info = NULL;
        $auth_token = NULL;
        $profile_image_name = NULL;
        $profile_image = NULL;
        $background_image_name = NULL;
        $background_image = NULL;
        $update_data = array();
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('user_id', 'User Id', 'required|trim', array('required' => 'Please enter  %s .'));
        $this->form_validation->set_rules('gender', 'Gender', 'required', array('required' => 'Please enter %s .'));
        //$this->form_validation->set_rules('core_values', 'Core Values', 'required', array('required' => 'Please enter %s .'));

        if ($this->form_validation->run() == TRUE) {
            $user_info = $this->user_model->findUserById($request_data['user_id']);
            if ($user_info != NULL) {
                if (!empty($_FILES['profile_pic'])) {
                    $profile_image_name = $_FILES['profile_pic']['name'];
                    $profile_image = image_upload(UPLOAD_USER_PROFILE_IMAGE_PATH . $user_info, 'profile_pic', '', TRUE);
                }
//                if (!empty($_FILES['background_pic'])) {
//                    $background_image_name = $_FILES['background_pic']['name'];
//                    $background_image = image_upload(UPLOAD_USER_BACKGROUND_IMAGE_PATH . '/' . $user_info, 'background_pic', '', FALSE);
//                }
                empty($profile_image_name) ? $profile_image_name = "" : $profile_image_name;
//                empty($background_image_name) ? $background_image_name = "" : $background_image_name;

                $update_data['eGender'] = $request_data['gender'];
                empty($request_data['email']) ?: $update_data['vEmail'] = $request_data['email'];
                $update_data['iUsersId'] = $request_data['user_id'];
                empty($request_data['size'])?: $update_data['fSize']=$request_data['size'];
                empty($request_data['size_type'])?:$update_data['eSizeType']=$request_data['size_type'];
                $update_data['vFbProfilePic'] = '';
                empty($request_data['weight'])?: $update_data['vWeight']=$request_data['weight'];
                empty($request_data['registration_status']) ?: $update_data['iRegisterationStatus']=$request_data['registration_status'];
                empty($request_data['weight_type']) ?: $update_data['eWeightType'] = $request_data['weight_type'];
                empty($request_data['age']) ?: $update_data['iAge'] = $request_data['age'];
                empty($request_data['core_values']) ?: $update_data['vCoreValues'] = $request_data['core_values'];
                empty($request_data['sports_master_id']) ?: $update_data['vSportsMasterId'] = $request_data['sports_master_id'];
                empty($profile_image['data']['file_name']) ?: $update_data['vProfilePic']= $profile_image['data']['file_name'];
                empty($profile_image['data']['file_name']) ?: $update_data['vThumbProfilePic'] = $profile_image['data']['file_name'];
                $update_data['dModifiedDate'] = date('Y-m-d H:i:s');
                empty($request_data['background_image_id']) ?: $update_data['vBackgroundImageId'] = $request_data['background_image_id'];
                $this->user_model->user_update($update_data);
                empty($update_data['vProfilePic']) ? $profile_pic="" : $profile_pic=base_url('assets/uploads/users/profile_images/').$user_info.'/'.$update_data['vProfilePic'];
                empty($update_data['vThumbProfilePic']) ? $thumb_profile_pic="" : $thumb_profile_pic=base_url('assets/uploads/users/profile_images/').$user_info.'/profile_images_thumb/'.$update_data['vThumbProfilePic'];
                $data_fields="vUsername AS user_name";
                $user_data=$this->user_model->getUserSelectedData($data_fields,$user_info);
                $data=["user_id"=>$user_info,"profile_pic"=>$profile_pic,"thumb_profile_pic"=>$thumb_profile_pic,"user_name"=>$user_data->user_name];
                $response['message'] = 'Profile set up sucessfully';
                $response['code'] = parent::HTTP_OK;
                $response['data'] = [$data];
                $response['status'] = true;
            } else {
                $response['message'] = 'Incorrect User Id';
                $response['code'] = parent::HTTP_OK;
                $response['data'] = array();
                $response['status'] = false;
            }
        } else {
            $response['data'] = array();
            $response['code'] = parent::HTTP_BAD_REQUEST;
            $response['message'] = validation_errors();
            $response['status'] = false;
        }

        $this->response($response, $response['code']);
    }
    public function social_login_post() {
        ini_set('display_errors', 1);
        error_reporting(E_ALL);
        $request_data = $this->_post_args;
        $response = array();
        $user_info = NULL;
        $auth_token = NULL;
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('social_type', 'Social Type', 'required', array('required' => 'Please enter  %s .', 'valid_email' => 'Please enter valid email %s .'));
        $this->form_validation->set_rules('social_id', 'Social Id', 'required', array('required' => 'Please enter  %s .'));
        //$this->form_validation->set_rules('latitude', 'Latitude', 'required', array('required' => 'Please enter your %s.'));
        //$this->form_validation->set_rules('longitude', 'Longitude', 'required', array('required' => 'Please enter your %s.'));
        $this->form_validation->set_rules('device_type', 'Device Type', 'required', array('required' => 'Please enter %s .'));
        $this->form_validation->set_rules('device_token', 'Device Token', 'required', array('required' => 'Please enter %s .'));

        if ($this->form_validation->run() == TRUE) {
             $user_exists = $this->user_model->check_user_exists($request_data['email']);
             
            if ($user_exists) {
                $update_data = array();
                    $updae_data['eSocialType'] = $request_data['social_type'];
                    $updae_data['tSocialId'] = $request_data['social_id'];
                    empty($request_data['latitude']) ?: $updae_data['vLatitude'] = $request_data['latitude'];
                    empty($request_data['longitude']) ?: $updae_data['vLongitude'] = $request_data['longitude'];
                    //'vFbProfilePic' => $request_data['fb_profile_pic'],
                    $updae_data['iUsersId'] = $user_exists;
                $this->user_model->user_update($update_data);
                $auth_token = generateAuthToken($user_exists);
                $update_device_data = array(
                    'vAccessToken' => $auth_token,
                    'vDeviceToken' => $request_data['device_token'],
                    'eDeviceType' => $request_data['device_type'],
                    'iUsersId' => $user_exists
                );
                $this->user_model->user_device_update($update_device_data);
                $data_fields="iUsersId AS user_id,vUsername AS user_name,vProfilePic AS profile_pic,vFbProfilePic AS fb_profile_pic,vEmail AS email,vLatitude AS latitude,vLongitude AS longitude,iRegisterationStatus AS registration_status";
                $user_data=$this->user_model->getUserSelectedData($data_fields,$user_exists);
                $user_data->access_token=$auth_token;
                empty($user_data->profile_pic) ? (empty($user_data->fb_profile_pic) ? $user_data->profile_pic="" : $user_data->profile_pic=$user_data->fb_profile_pic) : $user_data->profile_pic=base_url('assets/uploads/users/profile_images/').$user_data->user_id.'/'.$user_data->profile_pic;
                unset($user_data->fb_profile_pic); 
                $response['message'] = 'You have successfully login';
                    $response['code'] = parent::HTTP_OK;
                    $response['data'] = [$user_data];
                    $response['status'] = true;
            }
            else
            {
                
                $data = array();
                    $data['eSocialType'] = $request_data['social_type'];
                    empty($request_data['email']) ?: $data['vEmail'] = $request_data['email'];
                    empty($request_data['username']) ?: $data['vUsername'] = $request_data['username'];
                    empty($request_data['fb_profile_pic']) ?: $data['vFbProfilePic'] = $request_data['fb_profile_pic'];
                    $data['tSocialId'] = $request_data['social_id'];
                    empty($request_data['latitude']) ?: $data['vLatitude'] = $request_data['latitude'];
                    empty($request_data['longitude']) ?: $data['vLongitude'] = $request_data['longitude'];
                    $data['eStatus'] = 'Active';
                    $data['dAddedDate'] = date('Y-m-d H:i:s');
                /*if (!empty($_FILES['profile_pic'])) 
                    $contest_image = base_url(UPLOAD_IMAGE_PATH . '/' . $contest_id . '/' . $_FILES['profile_pic']['name']);
                */
                $user_id = $this->user_model->user_insert($data);
                $auth_token = generateAuthToken($user_id);
                 $device_data = array(
                    'iUsersId' => $user_id,
                    'vDeviceToken' => $request_data['device_token'],
                    'eDeviceType' => $request_data['device_type'],
                    'vAccessToken' => $auth_token,
                    'iIsPushNotification' => 1,
                    'dAddedDate' => date('Y-m-d H:i:s'),
                );
                $user_device_id = $this->user_model->user_device_insert($device_data);
                $data_fields="iUsersId AS user_id,vUsername AS user_name,vProfilePic AS profile_pic,vFbProfilePic AS fb_profile_pic,vEmail AS email,vLatitude AS latitude,vLongitude AS longitude,iRegisterationStatus AS registration_status";
                $user_data=$this->user_model->getUserSelectedData($data_fields,$user_id);
                $user_data->access_token=$auth_token;
                empty($user_data->fb_profile_pic) ? $user_data->profile_pic="" : $user_data->profile_pic=$user_data->fb_profile_pic;
                 unset($user_data->fb_profile_pic); 
                if ($user_id == false || $user_device_id == false ) {
                    $response['message'] = 'Failed to sign up for app';
                    $response['code'] = parent::HTTP_INTERNAL_SERVER_ERROR;
                    $response['data'] = array();
                    $response['status'] = false;
                    $this->response($response, $response['code']);
                }
                
                $response['message'] = 'You have successfully login';
                $response['code'] = parent::HTTP_CREATED;
                $response['data'] = [$user_data];
                $response['status'] = true;
            }
        } else {
            $response['data'] = array();
            $response['code'] = parent::HTTP_BAD_REQUEST;
            $response['message'] = validation_errors();
            $response['status'] = false;
        }

        $this->response($response, $response['code']);
    }

    public function signup_post() {
        $request_data = $this->_post_args;
        $response = array();
        $data = array();
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('email', 'Email', 'required|trim|valid_email', array('required' => 'Please enter  %s .', 'valid_email' => 'Please enter valid Email ID %s .'));
        $this->form_validation->set_rules('password', 'Password', 'required', array('required' => 'Please enter %s .'));
        $this->form_validation->set_rules('username', 'User Name', 'required', array('required' => 'Please enter your %s.'));
        //$this->form_validation->set_rules('latitude', 'Latitude', 'required', array('required' => 'Please enter your %s.'));
        //$this->form_validation->set_rules('longitude', 'Longitude', 'required', array('required' => 'Please enter your %s.'));
        $this->form_validation->set_rules('device_type', 'Device Type', 'required', array('required' => 'Please enter your %s.'));
        $this->form_validation->set_rules('device_token', 'Device Token', 'required', array('required' => 'Please enter your %s.'));

        if ($this->form_validation->run() == TRUE) {
                empty($request_data['username']) ?: $data['vUsername'] = $request_data['username'];
                $data['vEmail'] = $request_data['email'];
                empty($request_data['latitude']) ?: $data['vLatitude'] = $request_data['latitude'];
                empty($request_data['longitude']) ?: $data['vLongitude'] = $request_data['longitude'];
                $data['eStatus'] = 'Active';
                $data['dAddedDate'] = date('Y-m-d H:i:s');
                //'user_gender' => (empty($request_data['gender']) == false) ? $request_data['gender'] : 'M',
//            if (array_key_exists('dob', $request_data) && empty($request_data['dob']) == false) {
//                $data['user_birthdate'] = date('Y-m-d', strtotime($request_data['dob']));
//            }
            if (array_key_exists('password', $request_data) && empty($request_data['password']) == false) {
                $data['vPassword'] = generate_password_hash($request_data['password']);
            }

            $user_exists = $this->user_model->check_user_exists($request_data['email']);
            if ($user_exists) {
                $response['message'] = 'Email address already exists';
                $response['code'] = parent::HTTP_OK;
                $response['data'] = array();
                $response['status'] = false;
            } else {
                $user_id = $this->user_model->user_insert($data);
                
                $auth_token = generateAuthToken($user_id);

                $device_data = array(
                    'iUsersId' => $user_id,
                    'vDeviceToken' => $request_data['device_token'],
                    'eDeviceType' => $request_data['device_type'],
                    'vAccessToken' => $auth_token,
                    'iIsPushNotification' => 1,
                    'dAddedDate' => date('Y-m-d H:i:s'),
                );
                $user_device_id = $this->user_model->user_device_insert($device_data);
                $data_fields="iUsersId AS user_id,vUsername AS user_name,vProfilePic AS profile_pic,vFbProfilePic AS fb_profile_pic,vEmail AS email,vLatitude AS latitude,vLongitude AS longitude,iRegisterationStatus AS registration_status";
                $user_data=$this->user_model->getUserSelectedData($data_fields,$user_id);
                $user_data->access_token=$auth_token;
                empty($user_data->fb_profile_pic) ? $user_data->profile_pic="" : $user_data->profile_pic=$user_data->fb_profile_pic;
                 unset($user_data->fb_profile_pic); 

                if ($user_id == false || $user_device_id == false ) {
                    $response['message'] = 'Failed to sign up for app';
                    $response['code'] = parent::HTTP_INTERNAL_SERVER_ERROR;
                    $response['data'] = array();
                    $response['status'] = false;
                    $this->response($response, $response['code']);
                }
                
                $response['message'] = 'You have successfully registered';
                $response['code'] = parent::HTTP_CREATED;
                $response['data'] = [$user_data];
                $response['status'] = true;
            }
        } else {
            $response['data'] = array();
            $response['code'] = parent::HTTP_BAD_REQUEST;
            $response['message'] = validation_errors();
            $response['status'] = false;
        }
        $this->response($response, $response['code']);
    }

    public function forgotpassword_post() {

        $request_data = $this->_post_args;
        $response = array();
        $user_exists = false;
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('email', 'Email', 'required|trim|valid_email', array('required' => 'Please enter  %s .', 'valid_email' => 'Please enter valid Email ID %s .'));
        if ($this->form_validation->run() == TRUE) {
            $user_exists = $this->user_model->check_user_exists($request_data['email']);
            if ($user_exists) {

                // $user_token = generateAuthToken($user_exists);

                $user_data = $this->user_model->getUserData($user_exists);
                $new_password = generate_random_password();


                $update_data = array(
                    'vPassword' => generate_password_hash($new_password),
                    'iUsersId' => $user_exists
                );
                $this->user_model->user_update($update_data);


                /*$url = base_url() . "auth/index/?accesstoken=" . $user_token;


                  $body = "\nPlease click the following link to reset your password:\n\n" . $url . "\n\n";
                 */

                $message = "Hello " . $user_data->user_name . ",";
                $message.="\n";
                $message.="\n";

                $message.="We heard that you might have forgotten your FitMeUp™ password. ";
                //$message_reset_link.= 'To reset your password please click the link below and follow the instructions.' . $body;
                $message.="\n";
                $message.="\n";
                $message.="Your  password has been temporary reset to " . $new_password;
                $message.="\n";
                $message.="\n";
                $message.="Please reset this to a password that you will remember the next time you login.";
                $message.="\n";
                $message.="\n";
//                $message.="If you have any questions, please contact us at support@fitmeup.com";
//                $message.="\n";
//                $message.="\n";
                $message.="Thank you!";
                $message.="\n";
                $message.="\n";
                $message.="FitMeUp™ Team";


                send_mail(array('to' => $request_data['email'], 'subject' => 'Forgotten Password', 'message' => nl2br($message)));
                $response['message'] = "Your password has been sent at your email address";
                $response['code'] = parent::HTTP_OK;
                $response['data'] = array();
                $response['status'] = true;
            } else {
                $response['message'] = 'There is no User registered with this Email ID';
                $response['code'] = parent::HTTP_OK;
                $response['data'] = array();
                $response['status'] = false;
            }
        } else {
            $response['data'] = array();
            $response['code'] = parent::HTTP_BAD_REQUEST;
            $response['message'] = validation_errors();
            $response['status'] = false;
        }
        $this->response($response, $response['code']);
    }

    public function change_password_post() {

        $request_data = $this->_post_args;
        $response = array();
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('oldpassword', 'Old Password', 'required|trim|min_length[6]|max_length[20]', array('min_length' => 'The password you provided is invalid. Please provide a valid password with 6-15 alphanumeric characters.', 'max_length' => 'The password you provided is invalid. Please provide a valid password with 6-15 alphanumeric characters.'));
        $this->form_validation->set_rules('newpassword', 'New Password', 'required|trim|min_length[6]|max_length[20]', array('min_length' => 'The password you provided is invalid. Please provide a valid password with 6-15 alphanumeric characters.', 'max_length' => 'The password you provided is invalid. Please provide a valid password with 6-15 alphanumeric characters.'));
        if ($this->form_validation->run() == TRUE) {

            $user_current_pwd = NULL;
          
            $data_fields="iUsersId AS user_id,vUsername AS user_name,vFbProfilePic AS fb_profile_pic,vPassword AS password";
            $user_data=$this->user_model->getUserSelectedData($data_fields,$this->token_user_id);
            //$user_data = $this->user_model->getUserData($this->token_user_id);

            if (count($user_data) > 0) {
                $user_current_pwd = $user_data->password;
            }

            if (password_verify($request_data['oldpassword'], $user_current_pwd) == false) {
                $response['data'] = array();
                $response['code'] = parent::HTTP_OK;
                $response['message'] = "Old password must be same as your current password";
                $response['status'] = false;
            } else {

                $data['vPassword'] = generate_password_hash($request_data['newpassword']);
                $data['iUsersId'] = $this->token_user_id;
                $this->user_model->user_update($data);
                $response['message'] = 'Your Password has been updated successfully.';
                $response['code'] = parent::HTTP_OK;
                $response['data'] = array();
                $response['status'] = true;
            }
        } else {
            $response['data'] = array();
            $response['code'] = parent::HTTP_BAD_REQUEST;
            $response['message'] = validation_errors();
            $response['status'] = false;
        }
        $this->response($response, $response['code']);
    }
    public function change_email_post() {
        $request_data = $this->_post_args;
        $response = array();
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('oldemail', 'Old Email', 'required|valid_email');
        $this->form_validation->set_rules('newemail', 'New Email', 'required|valid_email');
        if ($this->form_validation->run() == TRUE) {

            $user_current_pwd = NULL;
            $user_exists = $this->user_model->check_user_exists($request_data['newemail']);
            $old_user_exists = $this->user_model->check_user_exists($request_data['oldemail']);
            if ($old_user_exists != FALSE) {
                if (($user_exists != FALSE && $user_exists==$old_user_exists)||($user_exists == FALSE)) {
                    $data['vEmail'] = $request_data['newemail'];
                    $data['iUsersId'] = $this->token_user_id;
                    $this->user_model->user_update($data);
                    $response['message'] = 'Your Email has been updated successfully.';
                    $response['code'] = parent::HTTP_OK;
                    $response['data'] = array();
                    $response['status'] = true;
                } else {
                    $response['message'] = 'This Email ID is already register with app.';
                    $response['code'] = parent::HTTP_OK;
                    $response['data'] = array();
                    $response['status'] = false;
                }
            } else {
                $response['message'] = 'There is no User registered with this Email ID';
                $response['code'] = parent::HTTP_OK;
                $response['data'] = array();
                $response['status'] = false;
            }
        } else {
            $response['data'] = array();
            $response['code'] = parent::HTTP_BAD_REQUEST;
            $response['message'] = validation_errors();
            $response['status'] = false;
        }
        $this->response($response, $response['code']);
    }

    public function google_post() {
        $request_data = $this->_post_args;

        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('email', 'Email', 'required|trim|valid_email', array('required' => 'Please enter  %s .', 'valid_email' => 'Please enter valid email %s .'));
        $this->form_validation->set_rules('google_id', 'Google Id', 'required|trim', array('required' => 'Please enter %s .'));
        $user_data = array();

        if ($this->form_validation->run() == TRUE) {
            $UserId = $this->user_model->check_user_exists($request_data['email']);
            if ($UserId == false) {
                $google_id_url = 'https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=' . $request_data['google_id'];
                $google_data = json_decode(file_get_contents($google_id_url));
                if (empty($google_data) || isset($google_data->error_description)) {
                    $response['data'] = array();
                    $response['code'] = parent::HTTP_BAD_REQUEST;
                    $response['message'] = "Error getting data from google." . $google_data->error_description;
                    $response['status'] = false;
                } else {
                    if (isset($google_data->given_name) && isset($google_data->family_name)) {
                        #$user_data['user_first_name'] = $google_data->given_name . ' ' . $google_data->family_name;
                        $user_data['user_first_name'] = $google_data->given_name;
                        $user_data['user_last_name'] = $google_data->family_name;
                    }
                    $user_data['user_email'] = $request_data['email'];
                    /* $user_data['user_status'] = 1;
                      $user_data['created_date'] = date('Y-m-d H:i:s');

                      $user_id = $this->user_model->user_insert($user_data);
                      $auth_token = generateAuthToken($user_id);
                      $user_data['access_token'] = $auth_token; */
                    $response['message'] = 'Authentication successful';
                    $response['code'] = parent::HTTP_OK;
                    $user_data['is_registered'] = false;
                    $response['data'] = $user_data;
                    $response['status'] = true;
                }
            } else {
                $user_data = $this->user_model->getUserData($UserId);
                if (count($user_data) > 0) {
                    switch (intval($user_data->user_status)) {
                        case 1:
                            if (array_key_exists('app_version', $request_data) && empty($request_data['app_version']) == false) {
                                $update_data = array(
                                    'app_version' => $request_data['app_version'],
                                    "user_id"=>$user_data->user_id
                                );
                                $this->user_model->user_update($update_data);
                                $user_data->app_version = $request_data['app_version'];
                            }
                            $response['message'] = 'Authentication successful';
                            $response['code'] = parent::HTTP_OK;
                            $response['data'] = array('is_registered' => true, 'user_id' => $user_data->user_id, 'is_upgraded' => $user_data->is_upgraded, 'name' => $user_data->name, 'app_version' => $user_data->app_version);
                            $response['status'] = true;
                            break;
                        default :
                            $response['message'] = 'Failed to authenticate';
                            $response['code'] = parent::HTTP_UNAUTHORIZED;
                            $response['data'] = array();
                            $response['status'] = false;
                            break;
                    }
                } else {
                    $response['message'] = 'Failed to authenticate';
                    $response['code'] = parent::HTTP_UNAUTHORIZED;
                    $response['data'] = array();
                    $response['status'] = false;
                }
            }
        } else {
            $response['data'] = array();
            $response['code'] = parent::HTTP_BAD_REQUEST;
            $response['message'] = validation_errors();
            $response['status'] = false;
        }
        $this->response($response, $response['code']);
    }

    public function userstatus_post() {
        $request_data = $this->_post_args;

        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('userId', 'User Id', 'required|trim', array('required' => 'Please enter  %s .'));

        $user_data = array();

        if ($this->form_validation->run() == TRUE) {
            $UserId = $this->user_model->findUserById($request_data['userId']);
            if ($UserId > 0) {
                $update_data = array(
                    'is_upgraded' => true,
                    'user_id' => $UserId
                );
                $this->user_model->user_update($update_data);
                $response['message'] = 'Status has been successfully updated';
                $response['code'] = parent::HTTP_OK;


                $response['status'] = true;
            } else {
                $response['message'] = 'Invalid UserId';
                $response['code'] = parent::HTTP_BAD_REQUEST;
                $response['data'] = array();
                $response['status'] = false;
            }
        } else {
            $response['data'] = array();
            $response['code'] = parent::HTTP_BAD_REQUEST;
            $response['message'] = validation_errors();
            $response['status'] = false;
        }
        $this->response($response, $response['code']);
    }
    public function main_feed_details_post() {
        ini_set('display_errors', 1);
        error_reporting(E_ALL);
        $request_data = $this->_post_args;
        $response = array();
        $user_info = NULL;
        $auth_token = NULL;
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('user_id', 'User Id', 'required', array('required' => 'Please enter  %s .'));

        if ($this->form_validation->run() == TRUE) {
            $page_index = isset($input_params["page_index"]) ? $input_params["page_index"] : 1;
            $user_exists = $this->user_model->findUserById($request_data['user_id']);
            if ($user_exists != FALSE) {
            $selectFields="iUserMediaId AS user_media_id,vFile AS image,vThumbFile AS thumb_image,vweight AS weight,eWeightType AS weight_type,dAddedDate AS added_date";
            $my_progress = $this->user_model->getMediaList($selectFields,$request_data['user_id']);
            $selectFields="iUserMediaId AS user_media_id,vweight AS weight,eWeightType AS weight_type,dAddedDate AS added_date";
            $my_weight = $this->user_model->getMediaList($selectFields,$request_data['user_id']);
            $selectFields="vLatitude AS latitude,vLongitude AS longitude";
            $user_data = $this->user_model->getUserSelectedData($selectFields,$request_data['user_id']);
            $blogs = $this->blog_model->getBlogList();
            $gyms = $this->gym_model->getGymList($page_index);
//            $gyms = $this->gym_model->getGymList();
           
             if($blogs){
                foreach($blogs as $blog){
                    $blog->blog_image=(empty($blog->blog_image)? "" : $blog->blog_image=base_url('assets/uploads/blogs/').$blog->blog_id.'/'.$blog->blog_image); 
                    $blog->blog_thumb_image=(empty($blog->blog_thumb_image)? "" : $blog->blog_thumb_image=base_url('assets/uploads/blogs/').$blog->blog_id.'/thumb/'.$blog->blog_thumb_image); 
                }
             }
             if($my_progress){
                foreach($my_progress as $my_prog){
                    $my_prog->image=(empty($my_prog->image)? "" : $my_prog->image=base_url('assets/uploads/users/media_images/').$my_prog->user_media_id.'/'.$my_prog->image); 
                    $my_prog->thumb_image=(empty($my_prog->thumb_image)? "" : $my_prog->thumb_image=base_url('assets/uploads/users/media_images/').$my_prog->user_media_id.'/thumb/'.$my_prog->thumb_image); 
                }
             }
             if($gyms){
                foreach($gyms as $gym){
                    $gym->gym_image=(empty($gym->gym_image)? "" : $gym->gym_image=base_url('assets/uploads/gyms/').$gym->gym_master_id.'/'.$gym->gym_image); 
                    $gym->gym_thumb_image=(empty($gym->gym_thumb_image)? "" : $gym->gym_thumb_image=base_url('assets/uploads/gyms/').$gym->gym_master_id.'/thumb/'.$gym->gym_thumb_image); 
                    $user_data->latitude=empty($user_data->latitude)? 0 : $user_data->latitude;
                    $user_data->longitude=empty($user_data->longitude)? 0 : $user_data->longitude;
                    if(isset($request_data['latitude']) && isset($request_data['latitude']) && $request_data['latitude']!=''&&$request_data['longitude']!='')
                        $gym->distance=(int)$this->distance($request_data['latitude'],$request_data['longitude'],$gym->latitude,$gym->longitude,"K");
                    else
                        $gym->distance=(int)$this->distance($user_data->latitude,$user_data->longitude,$gym->latitude,$gym->longitude,"K");
                }
             }
                $result=["my_progress_details"=>$my_progress,"my_weight_details"=>$my_weight,"blog_details"=>$blogs,"feture_gym_details"=>$gyms];
                    $response['message'] = 'success';
                    $response['code'] = parent::HTTP_OK;
                    $response['status'] = true;
                    $response['data'] = [$result];
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
    public function get_profile_data_post() {
        ini_set('display_errors', 1);
        error_reporting(E_ALL);
        $request_data = $this->_post_args;
        $response = array();
        $user_data = NULL;
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('user_id', 'User Id', 'required', array('required' => 'Please enter  %s .'));

        if ($this->form_validation->run() == TRUE) {
            $selectFields = "iUsersId AS user_id,vUsername AS user_name,vProfilePic AS profile_pic,vThumbProfilePic AS thumb_profile_pic,vFbProfilePic AS fb_profile_pic,vBackgroundPic AS background_image,vCoreValues AS core_values,IF(eUserType='pro','yes','no') AS is_pro_user,(SELECT COUNT(*) FROM user_awards WHERE iMediaOwnerId=" . $request_data['user_id'] . " AND eStatus='Yes') AS awards_count,(SELECT COUNT(*) FROM user_friend WHERE (iSenderId=" . $request_data['user_id'] . " OR iReceiverId=" . $request_data['user_id'] . ") AND eStatus IN('Accepted')) AS friends_count";
            $user_data = $this->user_model->getUserSelectedData($selectFields, $request_data['user_id']);
            if ($user_data != FALSE) {
               
                $selectFields = "iSportValueMasterId AS sports_master_id,vIcon AS icon,vActiveIcon AS active_icon";
                $sports_values = $this->user_model->getSportSelectedData($selectFields, $request_data['user_id']);
                $selectFields = "*";
//                $gif_data = $this->user_model->getGifData($selectFields, $request_data['user_id']);
                $gif_data = [];
                $selectFields = 'iUsersId AS friend_id,vProfilePic AS friend_profile_pic,vFbProfilePic AS friend_fb_profile_pic,vThumbProfilePic AS friend_thumb_profile_pic,IF(vUsername<>"",vUsername,vEmail) AS name';
                $friend_data = $this->user_model->getFriendData($selectFields, $request_data['user_id']);

                $user_data->profile_pic = (empty($user_data->profile_pic) ? (empty($user_data->fb_profile_pic) ? "" : $user_data->profile_pic = $user_data->fb_profile_pic) : $user_data->profile_pic = base_url('assets/uploads/users/profile_images') . $user_data->user_id . '/' . $user_data->profile_pic);
                $user_data->thumb_profile_pic = (empty($user_data->thumb_profile_pic) ? "" : $user_data->thumb_profile_pic = base_url('assets/uploads/users/profile_images') . $user_data->user_id . '/profile_images_thumb/' . $user_data->thumb_profile_pic);
                $user_data->background_image = (empty($user_data->background_image) ? "" : $user_data->background_image = base_url('assets/uploads/users/background_pic') . $user_data->user_id . '/' . $user_data->background_image);
                 unset($user_data->fb_profile_pic); 
                if ($sports_values) {
                    foreach ($sports_values as $sport_value) {
                        $sport_value->icon = (empty($sport_value->icon) ? "" : $sport_value->icon = base_url('assets/uploads/sport_values/') . $sport_value->sports_master_id . '/' . $sport_value->icon);
                        $sport_value->active_icon = (empty($sport_value->active_icon) ? "" : $sport_value->active_icon = base_url('assets/uploads/sport_values/') . $sport_value->sports_master_id . '/thumb/' . $sport_value->active_icon);
                    }
                }
                if ($friend_data) {
                    foreach ($friend_data as $friend) {
                        //var_dump(empty($friend->friend_profile_pic));
                        $friend->friend_profile_pic = (empty($friend->friend_profile_pic) ? (empty($friend->friend_fb_profile_pic) ? "" : $friend->friend_profile_pic = $friend->friend_fb_profile_pic) : $friend->friend_profile_pic = base_url('assets/uploads/users/profile_images/') . $friend->friend_id . '/' . $friend->friend_profile_pic);
                        $friend->friend_thumb_profile_pic = (empty($friend->friend_thumb_profile_pic) ? "" : $friend->friend_thumb_profile_pic = base_url('assets/uploads/users/profile_images/') . $friend->friend_id . '/profile_images_thumb/' . $friend->friend_thumb_profile_pic);
                        unset($friend->friend_fb_profile_pic); 
                    }
                }
                $result = ["user_details" => $user_data, "sports_values" => $sports_values, "gifs_list" => $gif_data, "friend_list" => $friend_data];
                $response['message'] = 'success';
                $response['code'] = parent::HTTP_OK;
                $response['status'] = true;
                $response['data'] = [$result];
            } else {
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
