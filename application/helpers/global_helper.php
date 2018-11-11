<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$CI = &get_instance();

function generateAuthToken($userId) {
    global $CI;
    $tokenId = base64_encode(uniqid());
    $serverName = $_SERVER['HTTP_HOST'];
    /*
     * Create the token as an array
     */
    $token_data = [
        // Issued at: time when the token was generated
        'jti' => $tokenId, // Json Token Id: an unique identifier for the token
        'iss' => $serverName, // Issuer
        'data' => [                  // Data related to the signer user
            'userId' => $userId // userid from the users table
        ]
    ];
    $jwt_token_secret_key = $CI->config->item('jwt_key');
    $authkey = \Firebase\JWT\JWT::encode(
                    $token_data, //Data to be encoded in the JWT
                    base64_decode($jwt_token_secret_key), // The signing key
                    'HS512'     // Algorithm used to sign the token, see https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-40#section-3
    );
    
    return $authkey;
}

function generate_password_hash($password) {
    $options = [
        'cost' => 11,
        'salt' => mcrypt_create_iv(50, MCRYPT_DEV_URANDOM),
    ];
    return password_hash($password, PASSWORD_BCRYPT, $options);
}

function ParseToken($array) {
    $CI = &get_instance();
    $jwt_token_secret_key = $CI->config->item('jwt_key');
    $CI->load->model('api/user_model');
    if (array_key_exists('accesstoken', $array) && strlen($array['accesstoken']) > 0) {
        $request_token = $array['accesstoken'];
        $secretKey = base64_decode($jwt_token_secret_key);
        $token_decoded = Firebase\JWT\JWT::decode($request_token, $secretKey, array('HS512'));
        if (property_exists($token_decoded, 'data')) {
            if (property_exists($token_decoded->data, 'userId')) {
                $token_info = $CI->user_model->getUserData($token_decoded->data->userId);
                if (count($token_info) > 0) {
                    return $token_decoded->data->userId;
                } else {
                    return false;
                }
            }
        }
    } else {
        return false;
    }
    return false;
}

function send_mail($data) {
    global $CI;
    $to = $data['to'];
    $sub = $data['subject'];
    $email_msg = $data['message'];
    $CI->load->library('email');
    $CI->config->load('email', TRUE);
    $CI->email->from('ankur.lakhani@indianic.com');
    $CI->email->to($to);
    $CI->email->subject($sub);
    $CI->email->set_mailtype('html');
    $CI->email->message($email_msg);
    return $CI->email->send();
}

function generate_random_password($length = 6) {
    $alphabets = range('A', 'Z');
    $numbers = range('0', '9');
    $additional_characters = array('_', '.');
    $final_array = array_merge($alphabets, $numbers, $additional_characters);

    $password = '';

    while ($length--) {
        $key = array_rand($final_array);
        $password .= $final_array[$key];
    }

    return $password;
}

function lang_url($uri = '', $protocol = NULL) {
    $CI = &get_instance();
    return base_url((isset($CI->multi_lang) && $CI->multi_lang ? ($CI->default_language . '/') : '') . $uri, $protocol);
}
if (!function_exists('delete')) {

    function delete($tbl = '', $whr = null) {
        $CI = &get_instance();
        return $CI->db->delete($tbl, $whr);
    }

}

if (!function_exists('change_status')) {

    function change_status($tbl = '', $set = null, $whr = null) {
        $CI = &get_instance();
        $CI->db->update($tbl, $set, $whr);
        //echo $CI->db->last_query();
        return 1;
    }
}
function set_flash_msg($msg = '', $type = 'success') {
    $CI = &get_instance();
    $CI->session->set_userdata(array('flsh_msg' => $msg, 'flsh_msg_type' => $type));
}

function unset_flash_msg() {
    $CI = &get_instance();
    $CI->session->unset_userdata(array('flsh_msg', 'flsh_msg_type'));
}
function process_pic($upload_dir, $uploads, $width, $height) {
    $CI = & get_instance();
    $CI->load->library('image_lib');
    
    $upload_dir = $upload_dir.'/profile_images_thumb/';
    if (!is_dir($upload_dir)) {
        mkdir($upload_dir, 0777);
    }
    
    $new_image_name = $upload_dir.$uploads['file_name'];

    //Creat Thumbnail
    $resize_config['image_library'] = 'GD2';
    $resize_config['source_image'] = $uploads['full_path'];
    $resize_config['create_thumb'] = TRUE;
    $resize_config['thumb_marker'] = '';
    $resize_config['master_dim'] = 'width';
    $resize_config['quality'] = 75;
    $resize_config['maintain_ratio'] = TRUE;
    $resize_config['width'] = $width;
    $resize_config['height'] = $height;
    $resize_config['new_image'] = $new_image_name;

    $CI->image_lib->initialize($resize_config);
    $CI->image_lib->resize();
    return TRUE;
}
if (!function_exists('image_upload')) {

    function image_upload($upload_dir, $file_name ='profile_pic', $allowed_types = 'jpg|jpeg|png|gif|mp3|mp4|m4a|mov|MOV|M4A', $resize = FALSE, $width = 100, $height = 100) {
        $allowed_types = ($allowed_types == '') ? 'jpg|jpeg|png|gif|mp3|mp4|m4a|mov|MOV|M4A' : $allowed_types;
        $CI = &get_instance();
        $return = [];
    //print_r($_FILES);die;
        if ($_FILES[$file_name]['size'] != 0) {
            
            $CI->load->library('upload');   
            if (!is_dir($upload_dir)) {
                mkdir($upload_dir, 0777,true);
                chmod($upload_dir,0777);
            }

           // $orig_filename = pathinfo($_FILES[$file_name]['name'], PATHINFO_FILENAME);
	     
	    $orig_filename = pathinfo($_FILES[$file_name]['name'], PATHINFO_FILENAME);
           
            $orig_filename = substr(preg_replace('/\_+/', '_',preg_replace('/[^a-zA-Z0-9_-]/', '_', $orig_filename)), 0, 30 ). time().rand();
           
            $config['upload_path'] = $upload_dir;
            $config['allowed_types'] = $allowed_types;
            
            $config['file_name'] = $orig_filename;
            $config['overwrite'] = FALSE;
            $config['max_size'] = '100000';
            $config['remove_spaces'] = TRUE;
            $config['encrypt_name'] = FALSE;
           
            $config['detect_mime'] = TRUE;
           
         // echo "<pre>";print_r($_FILES);die;
            $CI->upload->initialize($config);

            if (!$CI->upload->do_upload($file_name)) {
                $return['success'] = 0;
                $return['data'] = $CI->upload->display_errors();
            } else {
               
                $return['success'] = 1;
                $return['data'] = $CI->upload->data();
                if ($resize) {
                    process_pic($upload_dir, $return['data'], $width, $height);
                }
            }
        } else {
            $return['success'] = 0;
            $return['data'] = lang('no_file_selected');
        }

        return $return;
    }

}   