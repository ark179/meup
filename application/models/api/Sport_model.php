<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Sport_model extends CI_Model {

    function __construct() {
        parent::__construct();
        $this->sport_value_tableName = $this->db->dbprefix('sport_value_master');
    }

    function getSportValue() {
        $sport_value_info = array();
        $this->db->select("iSportValueMasterId AS sport_value_master_id,vIcon AS icon,vActiveIcon AS active_icon");
        $this->db->from($this->sport_value_tableName);
        $this->db->where(array('eStatus' => 'Active'));
        $sport_value_info = $this->db->get()->result();
        return $sport_value_info;
    }
}
