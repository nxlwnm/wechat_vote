<?php

import("@.ORG.wechat");
import("ORG.Net.Http");
#define('USER_MANAGER', 0);
#define ('USER_VOTER',1);
#define ('USER_UNAUTHORIZED', -1);
#define ('VOTE_STATE_READY',0);
#define ('VOTE_STATE_MANAGEMENT',1);
#define ('VOTE_STATE_MID',2);

class IndexAction extends Action {
  const USER_UNAUTHORIZED = -1;
  const USER_MANAGER = 0;
  const USER_VOTER = 1;
  const VOTE_STATE_READY = 0;
  const VOTE_STATE_MANAGEMENT = 1;
  const VOTE_STATE_MID = 2;
  const VOTE_STATE_CLUB = 3;
  const VOTE_STATE_END = 4;
  const NUM_OF_MANAGEMENT = 8;
  const NUM_OF_CLUB = 12;
  const NUM_OF_VOTE_LIMIT_MANAGEMENT = 6;
  const NUM_OF_VOTE_LIMIT_CLUB = 7;
  const MSG_VOTE_NOT_START = '投票环节尚未开始，您还可以仔细地思考手上的选票给哪位候选人喔:)';
  const MSG_CLUB_VOTE_NOT_START = '团委投票已经结束，但学生会投票环节尚未开始，您还可以仔细地思考手上的选票给哪位候选人喔';
  const MSG_VOTE_END = "投票环节已经结束！\n感谢您对数据科学与计算机学院第二次团员代表大会暨学生代表大会的大力支持！";
  const MSG_MANAGER_HINT = "指令输错啦，请重新输入！\n 管理部投票开始请输\"mbegin\"\n 常委投票开始请输\"cbegin\" 投票结束请输\"end\"";
  const MSG_VALID_VOTE = "指令输入正确！\n请重新输入并于主持人宣布投票正式开始后进行投票！\n感谢您对数据科学与计算机学院第二次团员代表大会暨学生代表大会的大力支持！";
  const MSG_INVALID_VOTE = "抱歉，指令输入有误！\n请输入您心仪的候选人的编号，并用空格隔开。\n";
  public function index(){
    $options = array(
     'token' => 'sysu'
    ); 
    $weObj = new Wechat($options);
    $weObj->valid();
    # get MsgType
    $type = $weObj->getRev()->getRevType();
    # content
    $revContent = $weObj->getRev();
    # openID
    $revFrom = $weObj->getRevFrom();
    # developer ID
    $revTo = $weObj->getRevTo();
    #echo $type;
    #check the info of the user
    
    $user_type = $this->checkAccount($revFrom);
    #$weObj->text( $user_type )->reply();return;
    switch($type) {
      case Wechat::MSGTYPE_TEXT: #只接受文字消息
        #$weObj->text( $user_type)->reply();
        $keyword = $weObj->getRevContent();
        $keyword = trim($keyword);
        if( $this->deal_with_key_word( $keyword, $weObj ) )
         return;
        #未认证用户
        if( $user_type ==  self::USER_UNAUTHORIZED ){
          $user = M('user');
          $map['code'] = $keyword;
          $data = $user->where( $map )->select(); #查找消息是否为验证码
          if( $data != false ){ #不是验证码
            if( $data[0]['active'] == 1 ){ #已激活
              if( $data[0]['auth'] == 1 )
                $weObj->text("亲爱的".$data[0]['name']."同学，您的投票代码已被使用，请勿重复登记信息，谢谢！")->reply();  
              if( $data[0]['auth'] == 2 ){
                $weObj->text("尊敬的".$data[0]['name']."同学，您的投票代码已被使用，请勿重复登记信息，谢谢！")->reply();  
              }
            }
            else{ #未激活，注册该用户
              $data[0]['openid'] = $revFrom;
              $data[0]['active'] = 1;
              $user->save( $data[0] );
              if( $data[0]['auth'] == 1 )
                $weObj->text("亲爱的".$data[0]['name']."同学，欢迎来到数据科学与计算机学院第二次团员代表大会暨学生代表大会！\n您的信息已经成功登记，请静候投票开始。\n感谢您对数据科学与计算机学院第二次团员代表大会暨学生代表大会的大力支持！")->reply(); 
              else{
                $weObj->text("尊敬的".$data[0]['name']."老师，您好！\n欢迎莅临数据科学与计算机学院第二次团员代表大会暨学生代表大会！\n请静候投票开始。\n感谢您对数据科学与计算机学院第二次团员代表大会暨学生代表大会的大力支持！")->reply(); 
              } 
            } 
          }
          else {
            $weObj->text("抱歉，您输入的候选人投票代码有误，请重新输入。\n回复\"团委\"可查看本次换届选举团委8名候选人的详细资料。\n回复\"学生会\"可查看本次换届选举12名学生会候选人的详细资料。\n感谢您对数据科学与计算机学院第二次团员代表大会暨学生代表大会的大力支持！")->reply();#\n回复“管理部”可查看管理部目前的投票结果\n回复“俱乐部”可查看俱乐部投票结果。\n感谢您对中山大学学生软件技术发展中心的大理支持！")->reply();
          }
        }
        #选举人
        else if( $user_type == self::USER_VOTER ){
          $voters = explode( ' ',$keyword);
          $state =$this->get_vote_state();
          #分投票状态处理
          #未开始投票
          if( $state == self::VOTE_STATE_READY ){
            if( $this->valid_voter( $voters ) ){
              $weObj->text( self::MSG_VALID_VOTE )->reply();
            }
            else{
              $res_msg = self::MSG_INVALID_VOTE."本轮您最多可投".self::NUM_OF_VOTE_LIMIT_MANAGEMENT."位候选人。\n";
							$voter_db = M('management');
							$can_data = $voter_db->select();
							foreach( $can_data as $candidate ){
								$res_msg .= $candidate['id']."号：".$candidate['name']."\n";
							}
              $weObj->text( $res_msg )->reply();
            }
          }
          #已结束
          else if( $state == self::VOTE_STATE_END ){
            $weObj->text( self::MSG_VOTE_END )->reply();
          }
          #中间休息阶段
          else if( $state == self::VOTE_STATE_MID ){
            if( $this->valid_voter( $voters ) ){
              $weObj->text( self::MSG_VALID_VOTE )->reply();
            }
            else{
              $res_msg = self::MSG_INVALID_VOTE."本轮您最多可投".self::NUM_OF_VOTE_LIMIT_CLUB."位候选人。\n";
							$voter_db = M('club');
							$can_data = $voter_db->select();
							foreach( $can_data as $candidate ){
								$res_msg .= $candidate['id']."号：".$candidate['name']."\n";
							}
              $weObj->text( $res_msg )->reply();
            }
          }
          #第一阶段
          else if( $state == self::VOTE_STATE_MANAGEMENT ){
            $user = M('user');
            $user_map['openid'] = $revFrom;
            $user_data = $user->where( $user_map )->select();
            $user_data = $user_data[0];

            $res_msg = "您已投票成功！您的投票结果为：\n";
            $voter_db = M('management');
            $vote_limit = self::NUM_OF_VOTE_LIMIT_MANAGEMENT;
            $vote_table = "m_vote";
            if( $user_data['state'] == 0 && $user_data['auth'] == 1 ){
                #$weObj->text('123')->reply();
               if( $this->valid_voter( $voters) ){    
                $vote_count = 1;
                $user_data['state'] = 1;
                $user_data['m_vote'] = $keyword;
                $user->save( $user_data );
               }
               else{
                $res_msg = self::MSG_INVALID_VOTE."本轮您最多可投".self::NUM_OF_VOTE_LIMIT_MANAGEMENT."位候选人。\n候选人信息如下所示：\n";
								$can_data = $voter_db->select();
								foreach( $can_data as $candidate ){
									$res_msg .= $candidate['id']."号：".$candidate['name']."\n";
								}
                $weObj->text( $res_msg )->reply();
                return;
               }
            }
						else if( $user_data['state'] == 0 && $user_data['auth'] == 2 ){
							if( $this->valid_voter( $voters) ){    
                $vote_count = 0;
                $user_data['state'] = 1;
                $user_data['m_vote'] = $keyword;
                $user->save( $user_data );
               }
               else{
                $res_msg = self::MSG_INVALID_VOTE."本轮您最多可投".self::NUM_OF_VOTE_LIMIT_MANAGEMENT."位候选人。\n候选人信息如下所示：\n";
								$can_data = $voter_db->select();
								foreach( $can_data as $candidate ){
									$res_msg .= $candidate['id']."号：".$candidate['name']."\n";
								}
                $weObj->text( $res_msg )->reply();
                return;
              }
						}
            else{
              $vote_count = 0;
              $voters = explode(' ', $user_data[$vote_table] );
            }

            $voter_map['id'] = array( 'in', $voters );
            $voter_data = $voter_db->where( $voter_map )->select();
            foreach ($voter_data as $voter) {
              $voter['count'] += $vote_count;
              $res_msg .= $voter['id']."号：".$voter['name']."（目前获".$voter['count']."票）\n";
              $voter_db->save( $voter );
            }
            $res_msg .= '感谢您对数据科学与计算机学院第二次团员代表大会暨学生代表大会的大力支持！';
            $weObj->text( $res_msg )->reply(); 
          }
          #第二阶段，注意必须投第一阶段才能投第二阶段
          else if( $state == self::VOTE_STATE_CLUB){
            $user = M('user');
            $user_map['openid'] = $revFrom;
            $user_data = $user->where( $user_map )->select();
            $user_data = $user_data[0];

            $res_msg = "您已投票成功！您的投票结果为：\n";
            $voter_db = M('club');
            $vote_limit = self::NUM_OF_VOTE_LIMIT_CLUB;
            $vote_table = "c_vote";

            if( $user_data['state'] == 1 && $user_data['auth'] == 1 ){
              if( $this->valid_voter($voters) ){    
                  $vote_count = 1;
                  $user_data['state'] = 2;
                  $user_data[$vote_table] = $keyword;
                  $user->save( $user_data );
                 }
                 else{
                  $res_msg = self::MSG_INVALID_VOTE."本轮您最多可投".self::NUM_OF_VOTE_LIMIT_CLUB."位候选人。\n候选人信息如下所示：\n";
									$can_data = $voter_db->select();
									foreach( $can_data as $candidate ){
										$res_msg .= $candidate['id']."号：".$candidate['name']."\n";
									}
                  $weObj->text( $res_msg )->reply();
                  return;
                 }
            }
						else if( $user_data['state'] == 1 && $user_data['auth'] == 2 ){
							if( $this->valid_voter( $voters) ){    
                $vote_count = 0;
                $user_data['state'] = 1;
                $user_data['m_vote'] = $keyword;
                $user->save( $user_data );
               }
               else{
                $res_msg = self::MSG_INVALID_VOTE."本轮您最多可投".self::NUM_OF_VOTE_LIMIT_CLUB."位候选人。\n候选人信息如下所示：\n";
								$can_data = $voter_db->select();
								foreach( $can_data as $candidate ){
									$res_msg .= $candidate['id']."号：".$candidate['name']."\n";
								}
                $weObj->text( $res_msg )->reply();
                return;
               }
						}
            else{
              $vote_count = 0;
              $voters = explode(' ', $user_data[$vote_table] );
            }
              
            $voter_map['id'] = array( 'in', $voters );
            $voter_data = $voter_db->where( $voter_map )->select();
            foreach ($voter_data as $voter) {
              $voter['count'] += $vote_count;
              $res_msg .= $voter['id']."号：".$voter['name']."（目前获".$voter['count']."票）\n";
              $voter_db->save( $voter );
            }
            $res_msg .= '感谢您对数据科学与计算机学院第二次团员代表大会暨学生代表大会的大力支持！';
            $weObj->text( $res_msg )->reply(); 
            
          }
        }
        #管理员
        else if( $user_type == self::USER_MANAGER ){
          #$weObj->text('abc')->reply();
          switch ($keyword) {
            case 'mbegin':
              if( $this->get_vote_state() == self::VOTE_STATE_READY ){
                $this->change_vote_state( self::VOTE_STATE_MANAGEMENT );
                $weObj->text( '操作成功，管理部投票开始！')->reply();
              }
              else{
                $weObj->text( '操作失败，请重新初始化再重新开始投票。\n投票先从管理部开始，再到常委会。')->reply(); 
              }
              # code...
              break;
            case 'cbegin':
              if( $this->get_vote_state() == self::VOTE_STATE_MID ){
                $this->change_vote_state( self::VOTE_STATE_CLUB );
                $weObj->text( '操作成功，常委投票开始！')->reply();
              }
              else{
                $weObj->text( "操作失败，请重新初始化再重新开始投票。\n投票先从管理部开始，再到常委会。")->reply(); 
              }
              break;
            case 'end':
              if( $this->get_vote_state() == self::VOTE_STATE_MANAGEMENT ){
                $this->change_vote_state( self::VOTE_STATE_MID );
                $weObj->text( '操作成功，管理部投票结束！')->reply();
              }
              else if( $this->get_vote_state() == self::VOTE_STATE_CLUB ){
                $this->change_vote_state( self::VOTE_STATE_END );
                $weObj->text( '操作成功，常委选举投票结束！')->reply();
              }
              else{
                $weObj->text( '操作失败，请重新初始化再重新开始投票。\n投票先从管理部开始，再到常委会。')->reply(); 
              }
              break;
            case 'init': #初始化会清空用户openid，选举开始后千万别init，如票数相同需要重新投票请用again
              $this->init();
              $weObj->text( "初始化成功！")->reply();
              break;
            case 'again': #重置投票，但不清空openid
              $this->again();
              $weObj->text("重新投票开始")->reply();
              break;
            default:
              $weObj->text('错误指令，请重新输入，谢谢')->reply();
              break;
          }
        }
        break;
      default:
        $weObj->text("感谢关注数据科学与计算机学院团委！\n数据科学与计算机学院第二次团员代表大会暨学生代表大会正火热进行中！\n回复\"团委\"可查看团委8名候选人详细资料。\n回复\"学生会\"可查看学生会12名候选人的详细资料。\n")->reply();   
    }
  }




  
  public function get_M_data(){
    $management = M('management');
    $data = $management->select();
    echo json_encode( $data  );
  }
  
  public function get_C_data(){
    $club = M('club');
    $data = $club->select();
    echo json_encode( $data );
  }
  # key word must not be management or club, return false or not return true;
  private function deal_with_key_word( $word, $weObj ){
   switch( $word ){
    case '团委':
     /*$data = array(
	   	"0"=>array(
	   		'Title'=>'中心管理部1号候选人顾斐',
	   		'Description'=>'summary text',
	   		'PicUrl'=>'http://121.199.60.94/pic/1.jpg',
	   		'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214431&idx=1&sn=fd84b76622cc961d69cf40512db03229#rd'
	   	),
	   	"1"=>array(
                        'Title'=>'中心管理部2号候选人李萌雪',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/2.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214438&idx=1&sn=78676900da27273537b6cf4a0aaf91b0#rd'
                ),
                "2"=>array(
                        'Title'=>'中心管理部3号候选人彭华峰',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/3.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214445&idx=1&sn=035d797c8708cf5342cf419e9615deff#rd'
                ),
                "3"=>array(
                        'Title'=>'中心管理部4号候选人朱希冉',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/4.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214448&idx=1&sn=ff80a8a04e63dbdb61b7b2f0dbc17b77#rd'
                ),
                "4"=>array(
                        'Title'=>'中心管理部5号候选人王宝亿',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/5.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214461&idx=1&sn=ace851829b347e8d2562da331e0b45ad#rd'
                ),
                "5"=>array(
                        'Title'=>'中心管理部6号候选人张子暄',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/6.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214512&idx=1&sn=7d208213ca461440a8997364cbd8d782#rd'
                ),
                "6"=>array(
                        'Title'=>'中心管理部7号候选人周小兰',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/7.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214529&idx=1&sn=4a683d9def2c6fa235d9a6bae75a5d67#rd'
                ),
                "7"=>array(
                        'Title'=>'中心管理部8号候选人徐航',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/8.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214547&idx=1&sn=6f70771d01aa57702b1734fb22befc48#rd'
                )
             ); 
     $weObj->news( $data )->reply();*/
     $data = "1号候选人：...2号候选人...";
     $weObj->text($data)->reply();
     return true;
     break;
    case '学生会':
     /*$c_data = array(
	   	"0"=>array(
	   		'Title'=>'1号候选人黄慧仪及2号候选人范巧文',
	   		'Description'=>'summary text',
	   		'PicUrl'=>'http://121.199.60.94/pic/index.jpg',
	   		'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214267&idx=1&sn=d8d689928c6c15518ba6f257e0db2c4c#rd'
	   	),
	   	"1"=>array(
                        'Title'=>'3号候选人李怡君及4号候选人潘浩彬',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/index.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214315&idx=1&sn=43cf11d7093c14ababf6e0e7e9b423a8#rd'
                ),
                "2"=>array(
                        'Title'=>'5号候选人刘志伟及6号候选人苏嘉阳',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/index.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214346&idx=1&sn=d4fb3a7a5d4eeadabd1e524a4dedde49#rd'
                ),
                "3"=>array(
                        'Title'=>'7号候选人黄伟鹏及8号候选人袁伟佳',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/index.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214365&idx=1&sn=8c10f652ae886bb3194332995fd5eba1#rd'
                ),
                "4"=>array(
                        'Title'=>'9号候选人王凯斌及10号候选人左君博',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/index.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214389&idx=1&sn=f87bab78e5adfe49d70d7f17287ef217#rd'
                ),
                "5"=>array(
                        'Title'=>'11号候选人杨煜荣及12号候选人刘永康',
                        'Description'=>'summary text',
                        'PicUrl'=>'http://121.199.60.94/pic/index.jpg',
                        'Url'=>'http://mp.weixin.qq.com/s?__biz=MjM5Mjk1NjgyMA==&mid=200214400&idx=1&sn=16f7e9fc7ef6b32ce9a16f5a13527cb1#rd'
                )
              ); 
     $weObj->news( $c_data )->reply();*/
     $c_data = "一号候选人...二号候选人...";
     $weObj->text($c_data)->reply();
     return true;
     break;
    default:
     return false;
   }
  }

  private function again(){
    $m = new Model();
    #$m->query( "update user set c_vote = '' ");
    #$m->query( "update user set m_vote = '' ");
    #$m->query( "update user set openid = '' where auth = 1 " );
    $m->query( "update user set c_vote = '', m_vote = '', state=0 where auth > 0 " );
    $m->query( "update management set count = 0 " );
    $m->query( "update club set count = 0 ");
    $m->query( "update vote_info set state = 0 " );
  }
  
  private function init(){
    $m = new Model();
    #$m->query( "update user set c_vote = '' ");
    #$m->query( "update user set m_vote = '' ");
    #$m->query( "update user set openid = '' where auth = 1 " );
    $m->query( "update user set active = 0 ,c_vote = '', m_vote = '', openid = '', state=0 where auth > 0 " );
    $m->query( "update management set count = 0 " );
    $m->query( "update club set count = 0 ");
    $m->query( "update vote_info set state = 0 " );
  }

  private function get_vote_state(){
    $state = M('vote_info');
    $state_data = $state->select();
    return $state_data[0]['state'];
  }
  
  private function change_vote_state($state){
    $m = new Model();
    $m->query( "update vote_info set state = ".$state );
  }
  #to judge if content is valid: must be number, cannot contain number over limit
  private function valid_voter( $voters_arr ){
    $state = $this->get_vote_state();
    foreach ($voters_arr as $v) {
      if( ! is_numeric( $v ) ){
        return false;
      }
      if( $state == self::VOTE_STATE_MANAGEMENT or $state == self::VOTE_STATE_READY){
        if( $v <= 0 || $v > self::NUM_OF_MANAGEMENT)
          return false;
      }
      else if( $state == self::VOTE_STATE_CLUB ){
        if( $v <= 0 || $v > self::NUM_OF_CLUB ){
          return false;
        }
      }
    }
    if( $state == self::VOTE_STATE_MANAGEMENT or $state == self::VOTE_STATE_READY){
      if( count( $voters_arr) > self::NUM_OF_VOTE_LIMIT_MANAGEMENT )
        return false;
    }
    else{
      if( count( $voters_arr) > self::NUM_OF_VOTE_LIMIT_CLUB )
        return false;
    }
    return true;
  }
  #there is a doubt that if is 0 to 10?
  private function is_digit( $chr ){
   for( $i = 1; i <= 11; ++$i ){
    if( $i == $chr ){
     return true;
    }
   } 
   return false;
  }
  # query openid in database, if return if is manager or voter or unauthorized
  private function checkAccount( $openid ){
    $user = M('user');
    $map['openid'] = $openid;
    $data = $user->where( $map )->select();
    if( $data != false ){
      #if( $data[0]['auth'] == 0 )
      if( $data[0]['auth'] == self::USER_MANAGER )
        return self::USER_MANAGER;
      return self::USER_VOTER;
    }
    else
      return self::USER_UNAUTHORIZED;
  }
}
