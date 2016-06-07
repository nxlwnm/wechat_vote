<?php

class DataAction extends Action {
    public function index(){
        $Data = M('user'); // 实例化Data数据模型
        $data = $Data->select();
        echo json_encode($data);
        #echo 'hello';
    }
}