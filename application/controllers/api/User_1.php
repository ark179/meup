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
    }

    protected function middleware() {
        return array('auth|only:changepassword');
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
        $this->form_validation->set_rules('email', 'Email', 'required|trim|valid_email', array('required' => 'Please enter  %s .', 'valid_email' => 'Please enter valid email %s .'));
        $this->form_validation->set_rules('password', 'Password', 'required|trim|min_length[6]|max_length[20]', array('required' => 'Please enter %s .', 'min_length' => 'The password you provided is invalid. Please provide a valid password with 6-15 alphanumeric characters.', 'max_length' => 'The password you provided is invalid. Please provide a valid password with 6-15 alphanumeric characters.'));

        if ($this->form_validation->run() == TRUE) {
            $data = array(
                'email' => $request_data['email']
            );
            $user_info = $this->user_model->user_login($data);


            if ($user_info != NULL) {
                if (password_verify($request_data['password'], $user_info->user_pwd)) {
                    unset($user_info->user_pwd);

                    $auth_token = generateAuthToken($user_info->user_id);
                    $user_info->access_token = $auth_token;

                    $response['message'] = 'Authentication successful';
                    $response['code'] = parent::HTTP_OK;
                    $response['data'] = $user_info;
                    $response['status'] = true;
                } else {
                    $response['message'] = 'Incorrect Email ID or Password.';
                    $response['code'] = parent::HTTP_UNAUTHORIZED;
                    $response['data'] = array();
                    $response['status'] = false;
                }
            } else {
                $response['message'] = 'Incorrect Email ID or Password.';
                $response['code'] = parent::HTTP_UNAUTHORIZED;
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

    public function signup_post() {
        $request_data = $this->_post_args;
        $response = array();
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('email', 'Email', 'required|trim|valid_email', array('required' => 'Please enter  %s .', 'valid_email' => 'Please enter valid Email ID %s .'));
        $this->form_validation->set_rules('password', 'Password', 'required|trim|min_length[6]|max_length[20]', array('required' => 'Please enter %s .', 'min_length' => '%s must contain must contain 6 to 15 alphanumeric characters', 'max_length' => '%s should not exceed  %d characters.'));
        $this->form_validation->set_rules('fname', 'First Name', 'required', array('required' => 'Please enter your %s.'));
        $this->form_validation->set_rules('lname', 'Last Name', 'required', array('required' => 'Please enter your %s.'));
        $this->form_validation->set_rules('lname', 'Last Name', 'required', array('required' => 'Please enter your %s.'));
        $this->form_validation->set_rules('primary_use', 'Primary Use', 'required', array('required' => 'Please enter your %s.'));

        if ($this->form_validation->run() == TRUE) {
            $data = array(
                'user_first_name' => $request_data['fname'],
                'user_last_name' => $request_data['lname'],
                'user_email' => $request_data['email'],
                'user_pwd' => generate_password_hash($request_data['password']),
                'user_status' => 1,
                'created_date' => date('Y-m-d H:i:s'),
                'user_gender' => (empty($request_data['gender']) == false) ? $request_data['gender'] : 'M',
                'primary_use' => $request_data['primary_use']
            );
            if (array_key_exists('dob', $request_data) && empty($request_data['dob']) == false) {
                $data['user_birthdate'] = date('Y-m-d', strtotime($request_data['dob']));
            }

            $user_exists = $this->user_model->check_user_exists($request_data['email']);
            if ($user_exists) {
                $response['message'] = 'Email address already exists';
                $response['code'] = parent::HTTP_OK;
                $response['data'] = array();
                $response['status'] = false;
            } else {
                $user_id = $this->user_model->user_insert($data);
                if ($user_id == false) {
                    $response['message'] = 'Failed to sign up for app';
                    $response['code'] = parent::HTTP_INTERNAL_SERVER_ERROR;
                    $response['data'] = array();
                    $response['status'] = false;
                    $this->response($response, $response['code']);
                }
		$auth_token = generateAuthToken($user_id);
                    



                $response['message'] = 'You have successfully registered ';
                $response['code'] = parent::HTTP_CREATED;
                $response['data'] = array('id' => $user_id,'access_token'=>$auth_token);
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
        $this->form_validation->set_rules('email', 'Email', 'required|trim|valid_email');
        if ($this->form_validation->run() == TRUE) {
            $user_exists = $this->user_model->check_user_exists($request_data['email']);
            if ($user_exists) {

                // $user_token = generateAuthToken($user_exists);

                $user_data = $this->user_model->getUserData($user_exists);
                $new_password = generate_random_password();


                $update_data = array(
                    'user_pwd' => generate_password_hash($new_password),
                    'user_id' => $user_exists
                );
                $this->user_model->user_update($update_data);


                /* $url = base_url() . "auth/index/?accesstoken=" . $user_token;


                  $body = "\nPlease click the following link to reset your password:\n\n" . $url . "\n\n";
                 */

                $message = "Hello " . $user_data->name . ",";
                $message.="\n";
                $message.="\n";
                //$message_reset_link.= 'To reset your password please click the link below and follow the instructions.' . $body;

                $message.="Your  password has been temporary reset to " . $new_password . ".";
                $message.="\n";
                $message.="\n";
                //echo $message;
                send_mail(array('to' => $request_data['email'], 'subject' => 'Forgotten Password', 'message' => nl2br($message)));
                $response['message'] = "Your password has been sent at your email address";
                $response['code'] = parent::HTTP_OK;
                $response['data'] = array();
                $response['status'] = true;
            } else {
                $response['message'] = 'There is no User registered with this Email ID';
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

    public function changepassword_post() {

        $request_data = $this->_post_args;
        $response = array();
        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('old_pwd', 'Old Password', 'required|trim|min_length[6]|max_length[20]', array('min_length' => 'The password you provided is invalid. Please provide a valid password with 6-15 alphanumeric characters.', 'max_length' => 'The password you provided is invalid. Please provide a valid password with 6-15 alphanumeric characters.'));
        $this->form_validation->set_rules('new_pwd', 'New Password', 'required|trim|min_length[6]|max_length[20]', array('min_length' => 'The password you provided is invalid. Please provide a valid password with 6-15 alphanumeric characters.', 'max_length' => 'The password you provided is invalid. Please provide a valid password with 6-15 alphanumeric characters.'));
        if ($this->form_validation->run() == TRUE) {

            $user_current_pwd = NULL;
            $user_data = $this->user_model->getUserData($this->token_user_id);

            if (count($user_data) > 0) {
                $user_current_pwd = $user_data->user_pwd;
            }


            if (password_verify($request_data['old_pwd'], $user_current_pwd) == false) {
                $response['data'] = array();
                $response['code'] = parent::HTTP_BAD_REQUEST;
                $response['message'] = "Old password must be same as your current password";
                $response['status'] = false;
            } else {

                $data['user_pwd'] = generate_password_hash($request_data['new_pwd']);
                $data['user_id'] = $this->token_user_id;
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

    public function google_post() {
        $request_data = $this->_post_args;

        $this->form_validation->set_data($request_data);
        $this->form_validation->set_error_delimiters('', '');
        $this->form_validation->set_rules('email', 'Email', 'required|trim|valid_email', array('required' => 'Please enter  %s .', 'valid_email' => 'Please enter valid email %s .'));
        $this->form_validation->set_rules('google_id', 'Google Id', 'required|trim', array('required' => 'Please enter %s .'));
        $user_data = array();

        if ($this->form_validation->run() == TRUE) {
            $google_id_url = 'https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=' . $request_data['google_id'];
            $google_data = json_decode(file_get_contents($google_id_url));
            if (empty($google_data) || isset($google_data->error_description)) {
                $response['data'] = array();
                $response['code'] = parent::HTTP_BAD_REQUEST;
                $response['message'] = "Error getting data from google." . $google_data->error_description;
                $response['status'] = false;
            } else {
                if (isset($google_data->given_name) && isset($google_data->family_name)) {
                    $user_data['user_first_name'] = $google_data->given_name . ' ' . $google_data->family_name;
                }
                $user_data['user_email'] = $request_data['email'];
                $user_data['user_status'] = 1;
                $user_data['created_date'] = date('Y-m-d H:i:s');
                $user_id = $this->user_model->user_insert($user_data);
                $auth_token = generateAuthToken($user_id);
                $user_data['access_token'] = $auth_token;
                $response['message'] = 'Authentication successful';
                $response['code'] = parent::HTTP_OK;
                $response['data'] = $user_data;
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

}
