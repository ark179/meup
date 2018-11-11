<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class Blog_model extends CI_Model {

    function __construct() {
        parent::__construct();
        $this->blog_tableName = $this->db->dbprefix('blog');
    }
    function getBlogList() {
        $blog_info = array();
        $this->db->select("iBlogId AS blog_id,vBlogTitle AS blog_title,tBlogDesc AS blog_description,vBlogImage AS blog_image,vThumbBlogImage AS blog_thumb_image");
        $this->db->from($this->blog_tableName);
        $this->db->where(array('eStatus' => 'Active'));
        $this->db->order_by("dAddedDate", "DESC");
        $this->db->limit(10, 0);
        $blog_info = $this->db->get()->result();
        return $blog_info;
    }
    function getBlogListWithPagination($page_index=1,$blog_id='') {
        $blog_info = array();
        $this->db->select("iBlogId");
        $this->db->from($this->blog_tableName);
        $this->db->where(array('eStatus' => 'Active'));
        empty($blog_id) ?: $this->db->where(array('iBlogId' => $blog_id));
        $total_records = $this->db->count_all_results();
        $record_limit = 5;
        $current_page = intval($page_index) > 0 ? intval($page_index) : 1;
        $total_pages = $this->getTotalPages($total_records, $record_limit);
        $start_index = $this->getStartIndex($total_records, $current_page, $record_limit);
        
        $this->db->limit($record_limit, $start_index);
        $this->db->select("iBlogId AS blog_id,vBlogTitle AS blog_title,tBlogDesc AS blog_description,vBlogImage AS blog_image,vThumbBlogImage AS blog_thumb_image");
        $this->db->from($this->blog_tableName);
        $this->db->where(array('eStatus' => 'Active'));
        empty($blog_id) ?: $this->db->where(array('iBlogId' => $blog_id));
        $blog_info['data'] = $this->db->get()->result();
        $blog_info['page']['per_page'] = $record_limit;
        $blog_info['page']['curr_page'] = $current_page;
        $blog_info['page']['prev_page'] = ($current_page > 1) ? 1 : 0;
        $blog_info['page']['next_page'] = ($current_page+1 > $total_pages) ? 0 : 1;
        $blog_info['page']['count'] = $total_records;
        return $blog_info;
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
