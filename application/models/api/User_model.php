<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class User_model extends CI_Model {

    function __construct() {
        parent::__construct();
        $this->user_tableName = $this->db->dbprefix('users');
        $this->blog_tableName = $this->db->dbprefix('blog');
        $this->myprogress_tableName = $this->db->dbprefix('user_media');
        $this->gym_tableName = $this->db->dbprefix('gym_master');
        $this->user_device_tableName = $this->db->dbprefix('user_device');
        $this->background_image_tableName = $this->db->dbprefix('background_image_master');
        $this->sport_value_tableName = $this->db->dbprefix('sport_value_master');
    }

    function user_login($data) {
        $user_info = null;
        $this->db->select('iUsersId AS user_id,vEmail AS email,vUsername AS username,vProfilePic AS profile_pic,vFBProfilePic AS fb_profile_pic,vPassword AS password,vLatitude AS latitude,vLongitude AS longitude,iRegisterationStatus AS registration_status');
        $this->db->from($this->user_tableName);
        $this->db->where("(vEmail = '".$data['email']."' OR vUsername = '".$data['email']."' ) AND eStatus = 'Active'");
        $user_info = $this->db->get()->row();
        return $user_info;
    }

    function check_user_exists($email_id) {
        $query = null;
        $this->db->select('iUsersId AS user_id');
        $this->db->from($this->user_tableName);
        $this->db->where(array('vEmail' => $email_id,'eStatus'=>'Active'));
        $query = $this->db->get()->row();
        if ($query != NULL) {
            return $query->user_id;
        } else {
            return false;
        }
    }

    function user_insert($data) {

        if (!empty($data)) {
            $this->db->insert($this->user_tableName, $data);
            $last_insert_id = $this->db->insert_id();
            if ($last_insert_id > 0) {
                return $last_insert_id;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    function user_device_insert($data) {

        if (!empty($data)) {
            $this->db->insert($this->user_device_tableName, $data);
            $last_insert_id = $this->db->insert_id();
            if ($last_insert_id > 0) {
                return $last_insert_id;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    function getUserData($user_id) {
        $user_info = array();
        $this->db->select("iUsersId AS user_id,vUsername AS user_name");
        $this->db->from($this->user_tableName);
        $this->db->where(array('iUsersId' => $user_id));
        $user_info = $this->db->get()->row();
        return $user_info;
    }
    function getUserSelectedData($fields='',$user_id) {
        $user_info = array();
        $this->db->select($fields);
        $this->db->from($this->user_tableName);
        $this->db->where(array('iUsersId' => $user_id));
        $user_info = $this->db->get()->row();
        return $user_info;
    }
    function user_update($data) {
        if (!empty($data)) {
            $this->db->where('iUsersId', $data['iUsersId']);
            //  $this->db->where('user_type', 'user');
            $this->db->update($this->user_tableName, $data);
            #echo $this->db->last_query();exit;
            return true;
        } else {
            return false;
        }
    }
    function user_device_update($data) {
        if (!empty($data)) {
            $this->db->where('iUsersId', $data['iUsersId']);
            $this->db->update($this->user_device_tableName, $data);
            #echo $this->db->last_query();exit;
            return true;
        } else {
            return false;
        }
    }
    function findUserById($userId) {
        $query = null;
        $this->db->select('iUsersId AS user_id');
        $this->db->from($this->user_tableName);
        $this->db->where(array('iUsersId' => $userId,'eStatus'=>'Active'));
        $query = $this->db->get()->row();
        if ($query != NULL) {
            return $query->user_id;
        } else {
            return false;
        }
    }
    function getMediaList($selectFields,$userId='') {
        $gym_info = array();
        $this->db->select($selectFields);
        $this->db->from($this->myprogress_tableName);
        $this->db->where(array('iUsersId' => $userId));
        $this->db->where_in('eStatus',array('publish','share'));
        $this->db->order_by("dAddedDate", "DESC");
        $this->db->limit(10, 0);
        //$this->db->limit($limit, $start);
        $gym_info = $this->db->get()->result();
        return $gym_info;
    }
    function getBackgroundImage() {
        $gym_info = array();
        //$this->db->select("iBackgroundImageMasterId AS background_image_master_id,vImage AS image,vThumbImage AS thumb_image");
        $this->db->select("iBackgroundImageMasterId AS background_image_master_id,vImage AS image");
        $this->db->from($this->background_image_tableName);
        $gym_info = $this->db->get()->result();
        return $gym_info;
    }
    function getSportSelectedData($fields = '', $user_id) {
        $user_info = array();
        $this->db->select($fields);
        $this->db->from($this->sport_value_tableName);
        $this->db->where("FIND_IN_SET(iSportValueMasterId,(SELECT vSportsMasterId AS sport_master_id FROM users WHERE iUsersId=".$user_id."))");
        $user_info = $this->db->get()->result();
        return $user_info;
    }
    function getFriendData($fields = '', $user_id) {
        $user_info = array();
        $this->db->select($fields);
        $this->db->from('users AS u');
        $this->db->join('user_friend AS uf1', 'u.iUsersId =uf1.iReceiverId','left');
        $this->db->join('user_friend AS uf2', 'u.iUsersId =uf2.iSenderId','left');
        $this->db->where("(uf1.iSenderId=1 OR uf2.iReceiverId=1) AND (uf1.eStatus='Accepted' OR uf2.eStatus='Accepted')");
        $user_info = $this->db->get()->result();
                //echo $this->db->last_query();die;
        return $user_info;
    }

}
