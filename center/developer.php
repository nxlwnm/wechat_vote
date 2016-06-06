<?php
/**
  * wechat php test
  */

//define your token
define("TOKEN", "venus");
define("SUPERPASS","jackie123");
$wechatObj = new wechatCallbackapiTest();
$wechatObj->responseMsg();

class wechatCallbackapiTest
{
	public function valid()
    {
        $echoStr = $_GET["echostr"];

        //valid signature , option
        if($this->checkSignature()){
        	echo $echoStr;
        	exit;
        }
    }

    public function responseMsg()
    {
		$text = "<xml>
				<ToUserName><![CDATA[aaaaa]]></ToUserName>
				<FromUserName><![CDATA[%s]]></FromUserName>
				<CreateTime>1348831860</CreateTime>
				<MsgType><![CDATA[text]]></MsgType>
				<Content><![CDATA[%d]]></Content>
				<MsgId>1234567890123456</MsgId>
				</xml>";     
		//get post data, May be due to the different environments
		$postStr = $_GET['data'];
		if($postStr=="")
		{
			$postStr = $GLOBALS["HTTP_RAW_POST_DATA"];
		}
		else
		{
			$randStr = "";
			for ($i = 0; $i < 100; $i++) 
			{
				$randStr .= chr(mt_rand(97, 122));
			}
			$randNum = mt_rand(1, 10);
			$postStr = sprintf($text, $randStr,$randNum);
			echo $randNum.$randStr;
		}
		
      	//extract post data
		if (!empty($postStr)){
                
              	$postObj = simplexml_load_string($postStr, 'SimpleXMLElement', LIBXML_NOCDATA);
                $fromUsername = $postObj->FromUserName;
                $toUsername = $postObj->ToUserName;
                $keyword = trim($postObj->Content);
                $time = time();
                $textTpl = "<xml>
							<ToUserName><![CDATA[%s]]></ToUserName>
							<FromUserName><![CDATA[%s]]></FromUserName>
							<CreateTime>%s</CreateTime>
							<MsgType><![CDATA[%s]]></MsgType>
							<Content><![CDATA[%s]]></Content>
							<FuncFlag>0</FuncFlag>
							</xml>";             
				if(!empty( $keyword ))
                {
              		$msgType = "text";
					
					$msg=explode(' ',$keyword);
					$command=$msg[0];
					
					//连接数据库
					$con = mysql_connect("localhost", "root", "dabad7594c");
					if (!$con)
					{
						die('Could not connect: ' . mysql_error());
					}
					//选择venus数据库
					$db_selected = mysql_select_db("venus",$con);
					
					$sql = "start transaction";
					mysql_query($sql,$con);
					if($command == SUPERPASS)
					{
						$sql = "select * from manager where weixin = '".$fromUsername."'";
						$result = mysql_query($sql,$con);
						$num = mysql_num_rows($result);
						if($num==0)
						{
							$sql = "insert into manager values('".$fromUsername."')";
							$result = mysql_query($sql,$con);
						}
						$contentStr = "您已成为管理员！";
					}
					else
					{
						$sql = "select * from manager where weixin = '".$fromUsername."'";
						$result = mysql_query($sql,$con);
						$num = mysql_num_rows($result);
						if($num==0)
						{
							$sql = "select * from state";
							$result = mysql_query($sql,$con);
							$state = mysql_fetch_array($result,MYSQL_ASSOC);
							if($state['state']==1)
							{
								$voteNum = (int)($command);
								if($voteNum>0 && $voteNum<=10)
								{
									$sql = "select * from info where id = ".$voteNum;
									$result = mysql_query($sql,$con);
									$info = mysql_fetch_array($result,MYSQL_ASSOC);
									if($info['state'])
									{
										$sql = "select * from record where weixin = '".$fromUsername."'";
										$result = mysql_query($sql,$con);
										$num = mysql_num_rows($result);
										if($num>=1)
										{
											$pre = mysql_fetch_array($result,MYSQL_ASSOC);
											if($pre['vote']!=$voteNum)
											{
												$sql = "update info set vote = vote - 1 where id = ".$pre['vote'];
												mysql_query($sql,$con);
												$sql = "delete from record where weixin = '".$fromUsername."'";
												mysql_query($sql,$con);
												$contentStr="您成功投票给".$info['id']."号".$info['name']."(之前为".$pre['vote']."号选手的投票将作废)！谢谢您的参与！";
												$sql = "update info set vote = vote + 1 where id = ".$voteNum;
												mysql_query($sql,$con);
												$sql = "insert into record values('".$fromUsername."',".$voteNum.")";
												mysql_query($sql,$con);	
											}
											else
											{
												$contentStr="您已投票给".$info['id']."号".$info['name'].",请勿重复投票，谢谢您的合作！";
											}
										}
										else
										{
											$sql = "update info set vote = vote + 1 where id = ".$voteNum;
											mysql_query($sql,$con);
											$sql = "insert into record values('".$fromUsername."',".$voteNum.")";
											mysql_query($sql,$con);		
											$contentStr="您成功投票给".$info['id']."号".$info['name']."!谢谢您的参与！";
										}
																
									}
									else
									{
										$contentStr = "很遗憾，".$voteNum."号选手".$info['name']."没有进入复活赛，请为进入复活赛的选手投票，谢谢合作！";
									}
								}
								else
								{
									$contentStr = "进入投票的候选人为\n";
									$sql = "select * from info";
									$result= mysql_query($sql,$con);
									while($row = mysql_fetch_array($result)){
										if($row['state'])
										{
											$contentStr=$contentStr."号码:".$row['id']."   名字:".$row['name']."\n";
										}
									}
									$contentStr=$contentStr."请发送正确的号码，谢谢合作！若您只是反馈意见，我们已作好记录，之后将人工为您解答。";
								}
							}
							else if($state['state']==2)
							{
								$contentStr = "大众投票环节已经截止，感谢您的参与！";
							}
							else
							{
								$contentStr = "大众投票环节还没开始，敬请期待！";
							}
						}
						else
						{
							if($command=="init")
							{
								$candidate=["阿尼木人声乐团","陈仕熙","邓浩辉","Senior","李璞","张璐","冯俊壹","长颈鹿乐队","侯宗宇","冰糖组合"];
								$sql = "delete from info";
								mysql_query($sql,$con);
								$sql = "update state set state=0";
								mysql_query($sql,$con);
								$sql = "delete from record";
								mysql_query($sql,$con);
								for($i=0;$i<10;$i++)
								{
									$sql = "insert into info values(".($i+1).",'".$candidate[$i]."',0,0)";
									mysql_query($sql,$con);
								}
								$contentStr = "初始化成功！";
							}
							else if($command=="begin")
							{
								$sql = "update state set state = 1";
								mysql_query($sql,$con);
								$contentStr = "投票开始！";
							}
							else if($command=="stop")
							{
								$sql = "update state set state = 2";
								mysql_query($sql,$con);
								$contentStr = "投票结束！";
							}
							else if($command=="clear")
							{
								$sql = "update info set vote = 0";
								mysql_query($sql,$con);
								$contentStr = "所有人的票数已经清零！";
							}
							else if($command=="getResult")
							{
								$sql = "select * from info";
								$result= mysql_query($sql,$con);
								$contentStr="";
								while($row = mysql_fetch_array($result)){
									if($row['state'])
									{
										$contentStr=$contentStr."号码:".$row['id']."   名字:".$row['name']."   票数:".$row['vote']."\n";
									}
								}
							}
							else if($command=="candidate")
							{
								for($i=1;$i<count($msg);$i++)
								{
									$cur = (int)($msg[$i]);
									if($cur>0 && $cur<=10)
									{
										$sql = "update info set state = 1 where id = ".$cur;
										mysql_query($sql,$con);
									}
								}
								$contentStr = "进入投票的候选人为\n";
								$sql = "select * from info";
								$result= mysql_query($sql,$con);
								while($row = mysql_fetch_array($result)){
									if($row['state'])
									{
										$contentStr=$contentStr."号码:".$row['id']."   名字:".$row['name']."\n";
									}
								}
							}
							else if($command=="add")
							{
								if(count($msg)==3)
								{
									if($msg[1]>=1 && $msg[1]<=10)
									{
										$sql = "update info set vote = vote + (".$msg[2].") where id = ".$msg[1];
										mysql_query($sql,$con);
										$contentStr="为".$msg[1]."号选手增加".$msg[2]."票成功。";
									}
									else
									{
										$contentStr="没有这个选手。";
									}
								}
								else
								{
									$contentStr="格式不对，请输入help查看格式。";
								}
							}
							else if($command=="all")
							{
								if(count($msg)==2)
								{
									if($msg[1] = (int)$msg[1])
									{
										$sql = "update info set vote = vote + (".$msg[1].")";
										mysql_query($sql,$con);
										$contentStr="为所有选手增加".$msg[1]."票成功。";
									}
									else
									{
										$contentStr="没有这个选手。";
									}
								}
								else
								{
									$contentStr="格式不对，请输入help查看格式。";
								}
							}
							else if($command=="exit")
							{
								$sql = "delete from manager where weixin = '".$fromUsername."'";
								mysql_query($sql,$con);
								$contentStr = "您已退出管理状态！";
							}
							else if($command=="test")
							{
								$contentStr = "您是管理员";
							}
							else
							{
								$contentStr = "错误的指令,详细指令操作见下\n";
								$contentStr = $contentStr."begin 开始投票\n";
								$contentStr = $contentStr."stop 停止投票\n";
								$contentStr = $contentStr."init 初始化\n";
								$contentStr = $contentStr."clear 将票数清零\n";
								$contentStr = $contentStr."getResult 获取当前投票结果\n";
								$contentStr = $contentStr."candidate 1 2 3 将1、2、3号选手设为可投票选手（以此类推）\n";
								$contentStr = $contentStr."test 检测是否已经成为管理员\n";
								$contentStr = $contentStr."add 1 10 给一号选手增加10票（以此类推）\n";
								$contentStr = $contentStr."exit 退出管理员状态\n";
							}
						}
					}
                	$resultStr = sprintf($textTpl, $fromUsername, $toUsername, $time, $msgType, $contentStr);
					$sql = "commit";
					mysql_query($sql,$con);
                	echo $resultStr;
                }else{
                	echo "Input something...";
                }

        }else {
        	echo "";
        	exit;
        }
    }
	
	private function checkSignature()
	{
        $signature = $_GET["signature"];
        $timestamp = $_GET["timestamp"];
        $nonce = $_GET["nonce"];	
        		
		$token = TOKEN;
		$tmpArr = array($token, $timestamp, $nonce);
		sort($tmpArr, SORT_STRING);
		$tmpStr = implode( $tmpArr );
		$tmpStr = sha1( $tmpStr );
		
		if( $tmpStr == $signature ){
			return true;
		}else{
			return false;
		}
	}
}

?>