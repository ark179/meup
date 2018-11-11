<?php

class Users_model extends CI_Model {

    var $table = 'tbl_users';

    public function __construct() {
        parent::__construct();
    }

    public function get_list() {
        $post = $this->input->post();
        $srchChars = $this->db->escape_like_str($post['sSearch']);
        $sortCols = 'user_'.$post['iSortTitle_0'];
        if($post['iSortTitle_0']=='primary_use')
        {
         $sortCols = $post['iSortTitle_0'];    
        }
        if($post['iSortTitle_0']=='app_version')
        {
         $sortCols = $post['iSortTitle_0'];    
        }
         if($post['iSortTitle_0']=='created_date')
        {
         $sortCols = $post['iSortTitle_0'];    
        }
        
        $sortOrdr = $post['sSortDir_0'];
        $offset = $post['iDisplayStart'];
        $limit = $post['iDisplayLength'];
        $sEcho = $post['sEcho'];

        $whr = 'WHERE user_type="user"';
        if ($srchChars != '') {
            $whr.= " AND (CONCAT_WS(' ',user_first_name,user_last_name) LIKE '%$srchChars%' OR user_email LIKE '%$srchChars%' OR primary_use LIKE '%$srchChars%') ";
        }
        $total = $this->db->query("SELECT COUNT(user_id) AS total_rows "
                        . "FROM {$this->table}  "
                        . "$whr")->row();

        $q = $this->db->query("SELECT user_id,user_first_name,user_status,user_last_name,user_email,primary_use,user_gender,user_birthdate,created_date,app_version "
                . "FROM {$this->table} "
                . "$whr "
                . "ORDER BY $sortCols $sortOrdr "
                . "LIMIT $offset, $limit");
              
               // echo $this->db->last_query();exit;
        $results = array();
        $rowCount=$q->num_rows();
        if ( $rowCount > 0) {
            foreach ($q->result() as $row) {
                $status = '';
                $results[] = array('id' => $row->user_id,'email'=>$row->user_email, 'first_name' => $row->user_first_name,'last_name' => $row->user_last_name,'primary_use'=>$row->primary_use, 'status' => $row->user_status,'gender'=>(($row->user_gender=='M')?'Male':(($row->user_gender=='F')?'Female':'Other')),'birthdate'=>$row->user_birthdate,'created_date'=>$row->created_date,'app_version'=>$row->app_version);
            }
        }

        $result = array(
            "sEcho" => $sEcho,
            "iTotalRecords" => $total->total_rows,
            "iTotalDisplayRecords" =>  $total->total_rows,
            "aaData" => $results
        );
        return $result;
    }
    
    public function get_users() {
        $post = $this->input->post();
        $srchChars = $this->db->escape_like_str($post['sSearch']);
       
      
       
        $whr = 'WHERE user_type="user"';
        if ($srchChars != '') {
            $whr.= " AND (CONCAT_WS(' ',user_first_name,user_last_name) LIKE '%$srchChars%' OR user_email LIKE '%$srchChars%' OR primary_use LIKE '%$srchChars%') ";
        }
       

        $q = $this->db->query("SELECT user_id,user_first_name,user_status,user_last_name,user_email,primary_use,user_gender,user_birthdate,created_date,app_version "
                . " FROM {$this->table} "
                . "$whr "
              
               );
              
               // echo $this->db->last_query();exit;
        $results = array();
        $rowCount=$q->num_rows();
        if ( $rowCount > 0) {
            foreach ($q->result() as $row) {
                $status = '';
                $results[] = array('id' => $row->user_id,'email'=>$row->user_email, 'first_name' => $row->user_first_name,'last_name' => $row->user_last_name,'primary_use'=>$row->primary_use, 'status' => $row->user_status,'user_gender'=>$row->user_gender,'user_birthdate'=>$row->user_birthdate,'created_date'=>$row->created_date,'app_version'=>$row->app_version);
            }
        }

       return $results;
    }


    public function get_user_details($id) {
        return $this->db->select('*')->from($this->table)->where(array('user_id' => $id))->get();
    }

    public function add() {
        $first_name = $this->input->post('first_name');
        $last_name = $this->input->post('last_name');
        $email = $this->input->post('email');
        $status = $this->input->post('status');
        $password = $this->input->post('password');
        $user_primary_use = $this->input->post('primary_use');
        
        
        
        $this->db->set('user_first_name', $first_name);
        $this->db->set('user_status', $status);
        $this->db->set('user_last_name', $last_name);
        $this->db->set('user_email', $email);
        $this->db->set('user_pwd',  generate_password_hash($password));
        $this->db->set('created_date', date('Y-m-d H:i:s'));
         $this->db->set('primary_use', $user_primary_use);
        $this->db->set('user_type', 'user');
        
        $this->db->insert($this->table);

        return $this->db->insert_id();
    }

    public function edit($id) {
        $first_name = $this->input->post('first_name');
        $last_name = $this->input->post('last_name');
        $email = $this->input->post('email');
        $status = $this->input->post('status');
        $user_primary_use = $this->input->post('primary_use');
        
     
        
        $this->db->set('user_first_name', $first_name);
        $this->db->set('user_status', intval($status));
        $this->db->set('user_last_name', $last_name);
        $this->db->set('user_email', $email);
        $this->db->set('primary_use', $user_primary_use);
        $this->db->where(array('user_id' => $id));
        $this->db->update($this->table);
        //echo $this->db->last_query();exit;

        return 1;
    }

}
