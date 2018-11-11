<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Gym_model extends CI_Model {

    function __construct() {
        parent::__construct();
        $this->gym_tableName = $this->db->dbprefix('gym_master');
    }
    function getGymList($page_index) {
        $gym_info = array();
        
        $this->db->select("iGymMasterId AS gym_master_id,vGymName AS gym_name,vDescription AS description,vImage AS gym_image,vThumbImage AS gym_thumb_image,vLatitude AS latitude,vLongitude AS longitude");
        $this->db->from($this->gym_tableName);
        $this->db->where(array('eStatus' => 'Active'));
        $this->db->order_by("dAddedDate", "DESC");
        $gym_info = $this->db->get()->result();
        return $gym_info;
    }
    function getGymListWithPagination($page_index=1,$gym_id='') {
        $gym_info = array();
        $this->db->select("iGymMasterId");
        $this->db->from($this->gym_tableName);
        $this->db->where(array('eStatus' => 'Active'));
        empty($gym_id) ?: $this->db->where(array('iGymMasterId' => $gym_id));
        $total_records = $this->db->count_all_results();
        $record_limit = 5;
        $current_page = intval($page_index) > 0 ? intval($page_index) : 1;
        $total_pages = $this->getTotalPages($total_records, $record_limit);
        $start_index = $this->getStartIndex($total_records, $current_page, $record_limit);
        
        $this->db->limit($record_limit, $start_index);
        $this->db->select("iGymMasterId AS gym_master_id,vGymName AS gym_name,vDescription AS description,vImage AS gym_image,vThumbImage AS gym_thumb_image,vLatitude AS latitude,vLongitude AS longitude");
        $this->db->from($this->gym_tableName);
        $this->db->where(array('eStatus' => 'Active'));
        empty($gym_id) ?: $this->db->where(array('iGymMasterId' => $gym_id));
        $this->db->order_by("dAddedDate", "DESC");
        $gym_info['data'] = $this->db->get()->result();
        $gym_info['page']['per_page'] = $record_limit;
        $gym_info['page']['curr_page'] = $current_page;
        $gym_info['page']['prev_page'] = ($current_page > 1) ? 1 : 0;
        $gym_info['page']['next_page'] = ($current_page+1 > $total_pages) ? 0 : 1;
        $gym_info['page']['count'] = $total_records;
        return $gym_info;
    }
    function getStartIndex($total, $page = 1, $recrod_limit = 20)
    {

        $start_index = ($page - 1) * $recrod_limit;
        return $start_index;
    }

    function getTotalPages($total_records, $records_per_page)
    {
        $total_pages = ceil($total_records / $records_per_page);
        return $total_pages;
    }
}
