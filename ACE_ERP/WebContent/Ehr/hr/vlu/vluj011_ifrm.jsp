<!--
*****************************************************
* @source       : vluj010.jsp
* @description  : JOB 프로필 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2012/04/02      이동훈        최초작성.
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>JOB 프로필(vluj011)</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style.css" rel="stylesheet" type="text/css">
<link href="/css/general.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var btnList = 'TFTTTFFT';
		var gs_format="";
		var gs_seq;
        var GUBUN   = "";
		var gs_gb="";
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

	            //검색조건 2가지
	            var BASIC_YMD_SHR = parent.document.form1.cmbYMD_SHR.value;        	//해당년도
				var ENO_NO = parent.document.form1.txtENO_NO_SHR.value;				//사번

				fnc_Row_Clear(1);

		        //정보 조회
				dsT_EV_JOBTASK.DataID = "/servlet/GauceChannelSVL?cmd=hr.vlu.j.vluj010.cmd.VLUJ010CMD&S_MODE=SHR_01&BASIC_YMD_SHR="+BASIC_YMD_SHR+"&ENO_NO="+ENO_NO;
				dsT_EV_JOBTASK.Reset();

			    if(dsT_EV_JOBTASK.namevalue(1,"JOB")==undefined&& dsT_EV_JOBTASK.namevalue(1,"TASK")==undefined&&
			    	dsT_EV_JOBTASK.namevalue(1,"TASKDESC")==undefined&& dsT_EV_JOBTASK.namevalue(1,"IMPORT")==undefined&&
			    	dsT_EV_JOBTASK.namevalue(1,"DEGREE")==undefined&& dsT_EV_JOBTASK.namevalue(1,"FREQUENCY")==undefined){
			    		txt_21.value="※직무(JOB)";
			    		txt_31.value="※과업(TASK)";
			    		txt_41.value="※본인 과업내용은 업적신고서 혹은 기작성한 직무기술서를 참고하시기 바랍니다.";
			    		txt_51.value=""
			    		txt_61.value=""
			    		txt_71.value=""
		    				
						fnc_SetDataHeader(2);

			    		dsT_EV_JOBTASK.Addrow();

		    			var gs_evayymm = BASIC_YMD_SHR.substring(0,4)+BASIC_YMD_SHR.substring(5,7);

		    			dsT_EV_JOBTASK.namevalue(1,"EVAYM")  		= gs_evayymm;
		    			dsT_EV_JOBTASK.namevalue(1,"ENO_NO")  		= parent.document.form1.txtENO_NO_SHR.value;
		    			dsT_EV_JOBTASK.namevalue(1,"SEQ")   			= eval("txt_1"+i).value;
		    			dsT_EV_JOBTASK.namevalue(1,"JOB") 				= eval("txt_2"+i).value;
		    			dsT_EV_JOBTASK.namevalue(1,"TASK") 			= eval("txt_3"+i).value;
		    			dsT_EV_JOBTASK.namevalue(1,"TASKDESC") 	= eval("txt_4"+i).value;
		    			dsT_EV_JOBTASK.namevalue(1,"IMPORT") 		= eval("txt_5"+i).value;			    		
		    			dsT_EV_JOBTASK.namevalue(1,"DEGREE") 		= eval("txt_6"+i).value;
		    			dsT_EV_JOBTASK.namevalue(1,"FREQUENCY") 	= eval("txt_7"+i).value;					    		
					}
        	}

			/******************************************************************************
				Description : DTL 화면 DISPLAY
			  parameter   :
			******************************************************************************/
			function fnc_SetFormat(i){

				  	gs_format +="<table  cellpadding=0 cellspacing=0 style=width:800px;height:30px;font-size:9pt;background-color:#ffffff;>"
					gs_format +="	<tr>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		<textarea id=txt_1"+i+"   style=width:30px;height:100px;overflow:auto;font-size:20pt;text-align:center;vertical-align:center; readOnly></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_2"+i+" style=width:80px;height:100px;overflow:auto;ime-mode:active; maxlength=50 onBlur=bytelength(this,this.value,50);></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_3"+i+" style=width:120px;height:100px;overflow:auto;ime-mode:active; maxlength=1000 onBlur=bytelength(this,this.value,200);></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_4"+i+" style=width:358px;height:100px;overflow:auto;ime-mode:active;  maxlength=50   onBlur=bytelength(this,this.value,600);></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_5"+i+" style=width:51px;height:100px;text-align:center;overflow:auto;ime-mode:active;  maxlength=50   onBlur=bytelength(this,this.value,3);></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_6"+i+" style=width:81px;height:100px;text-align:center;overflow:auto;ime-mode:active; maxlength=50 onBlur=bytelength(this,this.value,4);></textarea>"
					gs_format +="		</td>"
					gs_format +="		<td style=height:105px;border:1 solid #708090>"
					gs_format +="		 <textarea id=txt_7"+i+" style=width:81px;height:100px;text-align:center;overflow:auto;ime-mode:active; maxlength=50 onBlur=bytelength(this,this.value,20);></textarea>"
					gs_format +="		</td>"
					gs_format +="	</tr>"
					gs_format +="</table>";

			}


			/******************************************************************************************
				Descrition : 입력값 체크 (db2 입력시 입력값 2byte 변환후 자릿수 체크)
			******************************************************************************************/
			function bytelength(fe,bstr,mx) {

				var xx = "";
				var yy = "";
				var len = bstr.length;

				for (var i=0; i<bstr.length; i++) {
					xx = bstr.substr(i,1).charCodeAt(0);
					if (i!=0) yy = bstr.substr(i-1,1).charCodeAt(0);

					if (i==0) {
						if (xx>127) {	len++;len++; }
					} else {
						if (yy!="") {
							if (yy>127) { len++; }
							else { if (xx>127) { len++;len++; } }
						}
					}
				}

				if (bstr.substr(bstr.length-1,1).charCodeAt(0)>127) len++;

				// 클경우 메시지 뿌리기
				if (mx < len){
					alert('입력한 글이 길어서 잘릴수 있습니다.\n다시 입력하여 주십시요');
					fe.focus();
					fe.select();
				}

				return len;
			}


			/******************************************************************************
				Description : 데이타셋 ==> 화면데이타 저장 (DTL)
			******************************************************************************/
			function fnc_Display(i){

					eval("txt_1"+i).value=dsT_EV_JOBTASK.namevalue(i,"SEQ");
					eval("txt_2"+i).value=dsT_EV_JOBTASK.namevalue(i,"JOB");
					eval("txt_3"+i).value=dsT_EV_JOBTASK.namevalue(i,"TASK");
					eval("txt_4"+i).value=dsT_EV_JOBTASK.namevalue(i,"TASKDESC");
					eval("txt_5"+i).value=dsT_EV_JOBTASK.namevalue(i,"IMPORT");
					eval("txt_6"+i).value=dsT_EV_JOBTASK.namevalue(i,"DEGREE");
					eval("txt_7"+i).value=dsT_EV_JOBTASK.namevalue(i,"FREQUENCY");
			}

			/******************************************************************************
				Description : 행삭제
				parameter : 1 - 1행만 남겨두고 삭제
				            2 - 모두 삭제후 초기 한 행 추가
			******************************************************************************/
			function fnc_Row_Clear(gbn){

					if(gbn==1){
						for(i=gs_seq;i>1;i--){
							table_1.deleteRow();
						}
						gs_seq=1;
					}else if(gbn==2){
						for(i=gs_seq;i>=1;i--){
							table_1.deleteRow();
						}
						fnc_Initial();
					}
			}

			/******************************************************************************
				Description : 초기
			******************************************************************************/

			function fnc_Initial(){

					gs_seq=1;

					gs_format ="";

					dsT_EV_JOBTASK.deleteall();

					var oRow = table_1.insertRow();

				  	var oCell = oRow.insertCell();

					fnc_SetFormat(gs_seq);

				  	oCell.innerHTML = gs_format;

					txt_11.value=1;

					fnc_SetDataHeader(2);

					dsT_EV_JOBTASK.addrow();
			}

			/******************************************************************************
				Description : 행추가
			******************************************************************************/
			function fnc_Add(){

			     fnc_SetDataHeader(2);

			     gs_seq+=1;

			     gs_format="";

				 fnc_SetFormat(gs_seq);

				 var oRow = table_1.insertRow();

				 var oCell = oRow.insertCell();

				 oCell.innerHTML = gs_format;

				 eval("txt_1"+gs_seq).value=gs_seq;

				 dsT_EV_JOBTASK.addrow();

				 fnc_Data(gs_seq);

			}

			/******************************************************************************
				Description : 화면 데이타 ==> 데이타셋 저장 (DTL)
			******************************************************************************/
			function fnc_Data(i){
					
		    	var gs_evaym = parent.document.form1.cmbYMD_SHR.value;        	//해당년도

				dsT_EV_JOBTASK.namevalue(i,"ENO_NO")  		= parent.document.form1.txtENO_NO_SHR.value;
				dsT_EV_JOBTASK.namevalue(i,"EVAYM")  			= gs_evaym;
				dsT_EV_JOBTASK.namevalue(i,"SEQ")    			= eval("txt_1"+i).value;
				dsT_EV_JOBTASK.namevalue(i,"JOB") 	 			= eval("txt_2"+i).value;
				dsT_EV_JOBTASK.namevalue(i,"TASK") 			= eval("txt_3"+i).value;
				dsT_EV_JOBTASK.namevalue(i,"TASKDESC") 		= eval("txt_4"+i).value;
				dsT_EV_JOBTASK.namevalue(i,"IMPORT") 			= eval("txt_5"+i).value;
				dsT_EV_JOBTASK.namevalue(i,"DEGREE") 			= eval("txt_6"+i).value;
				dsT_EV_JOBTASK.namevalue(i,"FREQUENCY") 	= eval("txt_7"+i).value;

			}

			/******************************************************************************
				Description : 데이타 셋 헤드 설정
			******************************************************************************/
			function fnc_SetDataHeader(gbn){

				if(gbn==1){       //직무분류등

					if (dsT_EV_JOBSPEC.countrow<1){
							var s_temp = " EVAYM:STRING(6),ENO_NO:STRING(7),ENO_NM:STRING(30),HEAD_CD:STRING(4),HEAD_NM:STRING(50),"
											 + " DPT_CD:STRING(4),DPT_NM:STRING(50),TEAM_CD:STRING(4),TEAM_NM:STRING(50),JOB_CD:STRING(4),JOB_NM:STRING(50), "
											 + " JOBCODE:STRING(4),JOBGRPH:STRING(20),JOBRR:STRING(20),JOBKIND:STRING(20),JOBNAME:STRING(50),"
			    							 + " JOBSM:STRING(2000),"
						 					 + " EDU:STRING(1),MAJOR:STRING(40),SEX:STRING(1),ETC:STRING(100),EXP:STRING(200),"
						 					 + " CERTIFICATE:STRING(200),FRGRD:STRING(200),OAGRD:STRING(200),TECH:STRING(500),"	
						 					 + " STUDY:STRING(200),STUDY2:STRING(200),STUDY3:STRING(200)";		
							dsT_EV_JOBSPEC.SetDataHeader(s_temp);
					}

				}else if(gbn==2){ //직무기술

					if (dsT_EV_JOBTASK.countrow<1){
						var s_temp = " ENO_NO:STRING(7),EVAYM:STRING(6),SEQ:DECIMAL(2),JOB:STRING(50),TASK:STRING(100),"
									 + " TASKDESC:STRING(300), IMPORT:DECIMAL(3),DEGREE:STRING(4), FREQUENCY:STRING(20)";
						dsT_EV_JOBTASK.SetDataHeader(s_temp);
					}

				}else if(gbn==3){ //print head

					if (dsT_EV_PRINT.countrow<1){
						var s_temp = " TITLE:STRING(50),"
									 +" EVAYM:STRING(6),ENO_NO:STRING(7),ENO_NM:STRING(30),HEAD_CD:STRING(4),HEAD_NM:STRING(50),"
									 + " DPT_CD:STRING(4),DPT_NM:STRING(50),TEAM_CD:STRING(4),TEAM_NM:STRING(50),JOB_CD:STRING(4),JOB_NM:STRING(50), "
									 + " JOBCODE:STRING(4),JOBGRPH:STRING(20),JOBRR:STRING(20),JOBKIND:STRING(20),JOBNAME:STRING(50),JOBSM:STRING(2000),"
				 					 + " EDU:STRING(1),MAJOR:STRING(40),SEX:STRING(1),ETC:STRING(100),EXP:STRING(200),"
				 					 + " CERTIFICATE:STRING(200),FRGRD:STRING(200),OAGRD:STRING(200),TECH:STRING(500),"	
				 					 + " STUDY:STRING(200),STUDY2:STRING(200),STUDY3:STRING(200)";		
						
						dsT_EV_PRINT.SetDataHeader(s_temp);
					}
				}

			}


        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

   			if(!fnc_Save_Chk()) return;

   			fnc_SetDataHeader(1);

			 dsT_EV_JOBSPEC.addrow();

			 var row = dsT_EV_JOBSPEC.rowposition;

			 var row2 = parent.dsT_EV_JOBSPEC.rowposition;

			 dsT_EV_JOBSPEC.namevalue(row,"ENO_NO")		=parent.dsT_EV_JOBSPEC.namevalue(row2,"ENO_NO");
			 dsT_EV_JOBSPEC.namevalue(row,"EVAYM")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"EVAYM");
			 dsT_EV_JOBSPEC.namevalue(row,"HEAD_CD")		=parent.dsT_EV_JOBSPEC.namevalue(row2,"HEAD_CD");
			 dsT_EV_JOBSPEC.namevalue(row,"DPT_CD")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"DPT_CD");
			 dsT_EV_JOBSPEC.namevalue(row,"TEAM_CD")		=parent.dsT_EV_JOBSPEC.namevalue(row2,"TEAM_CD");
			 dsT_EV_JOBSPEC.namevalue(row,"JOB_CD")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"JOB_CD");
			 dsT_EV_JOBSPEC.namevalue(row,"JOBGRPH")		=parent.dsT_EV_JOBSPEC.namevalue(row2,"JOBGRPH");
			 dsT_EV_JOBSPEC.namevalue(row,"JOBRR")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"JOBRR");
			 dsT_EV_JOBSPEC.namevalue(row,"JOBKIND")		=parent.dsT_EV_JOBSPEC.namevalue(row2,"JOBKIND");
			 dsT_EV_JOBSPEC.namevalue(row,"JOBNAME")		=parent.dsT_EV_JOBSPEC.namevalue(row2,"JOBNAME");
			 dsT_EV_JOBSPEC.namevalue(row,"JOBSM")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"JOBSM");
			 dsT_EV_JOBSPEC.namevalue(row,"EDU")				=parent.dsT_EV_JOBSPEC.namevalue(row2,"EDU");
			 dsT_EV_JOBSPEC.namevalue(row,"MAJOR")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"MAJOR");
			 dsT_EV_JOBSPEC.namevalue(row,"SEX")				=parent.dsT_EV_JOBSPEC.namevalue(row2,"SEX");
			 dsT_EV_JOBSPEC.namevalue(row,"ETC")				=parent.dsT_EV_JOBSPEC.namevalue(row2,"ETC");
			 dsT_EV_JOBSPEC.namevalue(row,"EXP")				=parent.dsT_EV_JOBSPEC.namevalue(row2,"EXP");
			 dsT_EV_JOBSPEC.namevalue(row,"CERTIFICATE")	=parent.dsT_EV_JOBSPEC.namevalue(row2,"CERTIFICATE");
			 dsT_EV_JOBSPEC.namevalue(row,"FRGRD")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"FRGRD");
			 dsT_EV_JOBSPEC.namevalue(row,"OAGRD")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"OAGRD");
			 dsT_EV_JOBSPEC.namevalue(row,"TECH")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"TECH");
			 dsT_EV_JOBSPEC.namevalue(row,"STUDY")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"STUDY");
			 dsT_EV_JOBSPEC.namevalue(row,"STUDY2")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"STUDY2");
			 dsT_EV_JOBSPEC.namevalue(row,"STUDY3")			=parent.dsT_EV_JOBSPEC.namevalue(row2,"STUDY3");			 

			for(i=1;i<=gs_seq;i++){

			  if(dsT_EV_JOBTASK.SysStatus(i)!=2){

				  fnc_Data(i);

				}
			}

            trT_EV_JOBSPEC.KeyValue = "tr01(I:dsT_EV_JOBSPEC=dsT_EV_JOBSPEC,I:dsT_EV_JOBTASK=dsT_EV_JOBTASK)";
            trT_EV_JOBSPEC.action = "/servlet/GauceChannelSVL?cmd=hr.vlu.j.vluj010.cmd.VLUJ010CMD&S_MODE=SAV";

			//prompt('dsT_EV_JOBSPEC',dsT_EV_JOBSPEC.text);
			//prompt('dsT_EV_JOBTASK',dsT_EV_JOBTASK.text);

            trT_EV_JOBSPEC.post();

        }



		/******************************************************************************
			Description : 입력값 체크
		******************************************************************************/
		function fnc_Save_Chk() {

		  var dbltemp=0;

		  //필수항목 체크
		 	for(i=1;i<=gs_seq;i++){

				if(eval("txt_2"+i).value==""){
					alert("직무를 입력하십시요.");
					return false;
				}

				if(eval("txt_3"+i).value==""){
					alert("과업을 입력하십시요.");
					return false;
				}

				if(eval("txt_4"+i).value==""){
					alert("과업 내용을 입력하십시요.");
					return false;
				}

				if(eval("txt_5"+i).value==""){
					alert("비중을 입력하십시요.");
					return false;
				}

				if(eval("txt_6"+i).value==""){
					alert("난이도를 입력하십시요.");
					return false;
				}

				if(eval("txt_7"+i).value==""){
					alert("발생빈도를 입력하십시요.");
					return false;
				}

				var str2="";
				
				var intdegree=0;
				
				str2=eval("txt_6"+i).value;
				
				intdegree=str2.length;
				
				if(intdegree!=1) {
					
					alert("상/중/하 중에 입력하여 주십시오.");
					
					return false;
				}
				
			}
		  




		  //숫자체크
			var str="";

			for(j=1;j<=gs_seq;j++){
				str="txt_5"+j+"";
			  if(!fnc_ChkNumber(str)) return false;
		  	}

		  	for(j=1;j<=gs_seq;j++){
				dbltemp=parseInt(dbltemp)+parseInt(eval("txt_5"+j).value);
		  	}

			if(dbltemp!=100) {
				alert("가중치 합계가 100이 아닙니다. 확인 바랍니다.");
				//return false;
			}

			return true;
		}



		/******************************************************************************************
			Descrition : 날짜의 숫자 체크
		******************************************************************************************/
		function fnc_ChkNumber(obj){
			var str="";
			var sChk=0;
			var src=eval(obj).value;

			for(var i=0;i<src.length;i++){
				if(isNaN(src.charAt(i))||src.charAt(i)==" ") sChk+=1;
				else str+=src.charAt(i);
			}

			if(sChk!=0){
				alert("가중치에는 숫자만 입력하십시요.");
				obj.value=src;
				//return false;
			}
			return true;
		}

		/******************************************************************************************
				// 공백제거 Trim
		******************************************************************************************/
		function fnc_trim(str){

			var index,len;

			while(true){
				index = str.indexOf(" ");
				if(index == -1) break
				len = str.length;
				str = str.substring(0, index) + str.substring((index + 1),len)
			}
			return str;
		}

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요
			   if (table_1.rows.length>1) {

					dsT_EV_JOBTASK.DeleteRow(gs_seq);

				    gs_seq-=1;

			      	table_1.deleteRow();

			   }
        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요
        	dsT_EV_PRINT.ClearAll();

        	fnc_SetDataHeader(3);

        	dsT_EV_PRINT.Addrow();

        	dsT_EV_PRINT.namevalue(1,"TITLE")="2012년 개인별 JOB PROFILE"

        	dsT_EV_PRINT.namevalue(1,"EVAYM")			=parent.dsT_EV_JOBSPEC.namevalue(1,"EVAYM");
        	dsT_EV_PRINT.namevalue(1,"ENO_NO")		=parent.dsT_EV_JOBSPEC.namevalue(1,"ENO_NO");
        	dsT_EV_PRINT.namevalue(1,"ENO_NM")		=parent.dsT_EV_JOBSPEC.namevalue(1,"ENO_NM");
        	dsT_EV_PRINT.namevalue(1,"HEAD_CD")		=parent.dsT_EV_JOBSPEC.namevalue(1,"HEAD_CD");
        	dsT_EV_PRINT.namevalue(1,"HEAD_NM")		=parent.dsT_EV_JOBSPEC.namevalue(1,"HEAD_NM");
        	dsT_EV_PRINT.namevalue(1,"DPT_CD")			=parent.dsT_EV_JOBSPEC.namevalue(1,"DPT_CD");
        	dsT_EV_PRINT.namevalue(1,"DPT_NM")		=parent.dsT_EV_JOBSPEC.namevalue(1,"DPT_NM");
        	dsT_EV_PRINT.namevalue(1,"TEAM_CD")		=parent.dsT_EV_JOBSPEC.namevalue(1,"TEAM_CD");
        	dsT_EV_PRINT.namevalue(1,"TEAM_NM")		=parent.dsT_EV_JOBSPEC.namevalue(1,"TEAM_NM");    	
        	dsT_EV_PRINT.namevalue(1,"JOB_CD")			=parent.dsT_EV_JOBSPEC.namevalue(1,"JOB_CD");
        	dsT_EV_PRINT.namevalue(1,"JOB_NM")			=parent.dsT_EV_JOBSPEC.namevalue(1,"JOB_NM");
        	dsT_EV_PRINT.namevalue(1,"JOBGRPH")		=parent.dsT_EV_JOBSPEC.namevalue(1,"JOBGRPH");
        	dsT_EV_PRINT.namevalue(1,"JOBRR")			=parent.dsT_EV_JOBSPEC.namevalue(1,"JOBRR");
        	dsT_EV_PRINT.namevalue(1,"JOBKIND")		=parent.dsT_EV_JOBSPEC.namevalue(1,"JOBKIND");
        	dsT_EV_PRINT.namevalue(1,"JOBNAME")		=parent.dsT_EV_JOBSPEC.namevalue(1,"JOBNAME");
        	dsT_EV_PRINT.namevalue(1,"JOBSM")			=parent.dsT_EV_JOBSPEC.namevalue(1,"JOBSM");        	
        	dsT_EV_PRINT.namevalue(1,"EDU")				=parent.dsT_EV_JOBSPEC.namevalue(1,"EDU");
        	dsT_EV_PRINT.namevalue(1,"MAJOR")			=parent.dsT_EV_JOBSPEC.namevalue(1,"MAJOR");
        	dsT_EV_PRINT.namevalue(1,"SEX")				=parent.dsT_EV_JOBSPEC.namevalue(1,"SEX");
        	dsT_EV_PRINT.namevalue(1,"ETC")				=parent.dsT_EV_JOBSPEC.namevalue(1,"ETC");
        	dsT_EV_PRINT.namevalue(1,"EXP")				=parent.dsT_EV_JOBSPEC.namevalue(1,"EXP");
        	dsT_EV_PRINT.namevalue(1,"CERTIFICATE")	=parent.dsT_EV_JOBSPEC.namevalue(1,"CERTIFICATE");
        	dsT_EV_PRINT.namevalue(1,"FRGRD")			=parent.dsT_EV_JOBSPEC.namevalue(1,"FRGRD");
        	dsT_EV_PRINT.namevalue(1,"OAGRD")			=parent.dsT_EV_JOBSPEC.namevalue(1,"OAGRD");
        	dsT_EV_PRINT.namevalue(1,"TECH")			=parent.dsT_EV_JOBSPEC.namevalue(1,"TECH");
        	dsT_EV_PRINT.namevalue(1,"STUDY")			=parent.dsT_EV_JOBSPEC.namevalue(1,"STUDY");
        	dsT_EV_PRINT.namevalue(1,"STUDY2")			=parent.dsT_EV_JOBSPEC.namevalue(1,"STUDY2");
        	dsT_EV_PRINT.namevalue(1,"STUDY3")			=parent.dsT_EV_JOBSPEC.namevalue(1,"STUDY3");

        	//prompt(this, dsT_EV_PRINT.text)
        	
        	gcrp_print1.preview();	

        }




        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {


        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {


        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {


        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck(year) {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {



        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {




        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);

        }


    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                        |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_ABLRST)                       |
    | 3. 사용되는 Table List(T_EV_ABLRST)                              |
    +------------------------------------------------------------------>
    <Object ID="dsT_EV_JOBSPEC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_JOBTASK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_HWORKPRT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_LENGTH" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EV_PRINT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton            |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_ABLRST)        |
    | 3. 사용되는 Table List(T_EV_ABLRST)               |
    +--------------------------------------------------->
    <Object ID ="trT_EV_JOBSPEC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EV_JOBTASK Event="OnLoadCompleted(row,colid)">

	  	var oRow;

		var oCell;

		for(i=1;i<=row;i++){

			if(i>1){

				gs_format="";

				oRow= table_1.insertRow();

				oCell = oRow.insertCell();

				fnc_SetFormat(i);

				oCell.innerHTML = gs_format;

			}

			//조회 데이타 보여줌
			fnc_Display(i);
		}

		if (row==0)gs_seq = 1;

		else gs_seq = row;


    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_EV_JOBTASK Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>


    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_EV_JOBSPEC event="OnSuccess()">
        alert("성공적으로 저장하였습니다.");
        parent.fnc_SearchList()
    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_EV_JOBSPEC event="OnFail()">
        if (trT_EV_JOBSPEC.ErrorCode != 50015) {
            cfErrorMsg(this);
        }
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->


<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" scroll=auto onkeydown = "fnc_HotKey();" onload="fnc_OnLoadProcess();">

<!-- 내용 조회 그리드 테이블 시작-->
<table id="table_1" value="" width="798" border="0" cellspacing="0" cellpadding="0">
</table>
<!-- 내용 조회 그리드 데이블 끝-->


<comment id="__NSID__">
<object  id=gcrp_print1 classid=CLSID:CC26E2A9-760B-4EA6-8DDF-DB423FD24089>
	<param name="MasterDataID"			value="dsT_EV_PRINT">
	<param name="PaperSize"				value="A4">
	<param name="fixpapersize"			value="true">
	<param name="printMargine"			value="false">
	<param name="LandScape"				value="false">
  	<param name="PrintSetupDlgFlag" 	value="true">
	<param name="Format"				value="
	<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132, PageSkip=true
	<R>id='1쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='dsT_EV_PRINT'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=478 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=71 ,top=331 ,right=1942 ,bottom=402 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='직종' ,left=836 ,top=333 ,right=1265 ,bottom=397 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<X>left=619 ,top=108 ,right=1455 ,bottom=185 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=609 ,top=98 ,right=1445 ,bottom=175 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=71 ,top=328 ,right=1942 ,bottom=328 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='* 직무분류' ,left=71 ,top=254 ,right=908 ,bottom=318 ,align='left' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직렬' ,left=458 ,top=333 ,right=796 ,bottom=397 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='JOBRR', left=458, top=418, right=796, bottom=466, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOBKIND', left=836, top=418, right=1265, bottom=466, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=74 ,top=474 ,right=1942 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TITLE', left=614, top=103, right=1439, bottom=169, face='HY중고딕', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
	<L> left=421 ,top=333 ,right=421 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=421 ,top=407 ,right=421 ,bottom=471 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1270 ,top=333 ,right=1270 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=831 ,top=333 ,right=831 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1270 ,top=407 ,right=1270 ,bottom=471 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=831 ,top=407 ,right=831 ,bottom=471 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=333 ,right=71 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=407 ,right=71 ,bottom=471 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=328 ,right=1942 ,bottom=474 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=74 ,top=402 ,right=1942 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='직군' ,left=130 ,top=336 ,right=384 ,bottom=400 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='JOBGRPH', left=127, top=413, right=381, bottom=460, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOBNAME', left=1278, top=418, right=1937, bottom=466, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='직무명' ,left=1281 ,top=333 ,right=1937 ,bottom=397 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=2339 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=71 ,top=87 ,right=1942 ,bottom=161 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1032 ,top=855 ,right=1289 ,bottom=918 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1032 ,top=791 ,right=1289 ,bottom=855 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=344 ,top=855 ,right=601 ,bottom=918 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=344 ,top=791 ,right=601 ,bottom=855 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='기타' ,left=1042 ,top=860 ,right=1281 ,bottom=910 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=74 ,top=791 ,right=344 ,bottom=918 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='성별' ,left=355 ,top=860 ,right=595 ,bottom=910 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='학력' ,left=355 ,top=796 ,right=593 ,bottom=847 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=74 ,top=953 ,right=344 ,bottom=1384 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=74 ,top=230 ,right=1942 ,bottom=230 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=235 ,top=87 ,right=235 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='사번' ,left=79 ,top=90 ,right=228 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=74 ,top=161 ,right=1942 ,bottom=161 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=87 ,right=71 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ENO_NO', left=79, top=175, right=228, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=235 ,top=164 ,right=235 ,bottom=228 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=164 ,right=71 ,bottom=228 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ENO_NM', left=1593, top=175, right=1926, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='소속명 (본부/부서/팀)' ,left=241 ,top=90 ,right=1294 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='JOB_NM', left=1315, top=172, right=1558, bottom=220, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='HEAD_NM', left=241, top=175, right=537, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1942 ,top=164 ,right=1942 ,bottom=228 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1942 ,top=87 ,right=1942 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1574 ,top=161 ,right=1574 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1296 ,top=161 ,right=1296 ,bottom=225 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1296 ,top=90 ,right=1296 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1574 ,top=87 ,right=1574 ,bottom=159 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='* 직무 수행자 인적사항' ,left=71 ,top=11 ,right=908 ,bottom=74 ,align='left' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='* 직무 개요' ,left=71 ,top=270 ,right=908 ,bottom=333 ,align='left' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=71 ,top=355 ,right=1942 ,bottom=355 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=85 ,right=1942 ,bottom=85 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='일반 자격 요건' ,left=87 ,top=820 ,right=328 ,bottom=873 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='소요 역량' ,left=93 ,top=1106 ,right=333 ,bottom=1228 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=1945 ,top=953 ,right=1945 ,bottom=1384 </L>
	<T>id='* 직무 명세' ,left=71 ,top=685 ,right=908 ,bottom=749 ,align='left' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ETC', left=1296, top=865, right=1939, bottom=913, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MAJOR', left=1296, top=796, right=1939, bottom=844, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=71 ,top=355 ,right=71 ,bottom=661 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=661 ,right=1942 ,bottom=661 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=601 ,top=791 ,right=1942 ,bottom=791 </L>
	<L> left=601 ,top=953 ,right=1945 ,bottom=953 </L>
	<L> left=601 ,top=791 ,right=1945 ,bottom=791 </L>
	<L> left=601 ,top=1421 ,right=1945 ,bottom=1421 </L>
	<L> left=1945 ,top=1421 ,right=1945 ,bottom=1601 </L>
	<L> left=1945 ,top=791 ,right=1945 ,bottom=918 </L>
	<L> left=601 ,top=918 ,right=1945 ,bottom=918 </L>
	<L> left=601 ,top=855 ,right=1945 ,bottom=855 </L>
	<L> left=1942 ,top=355 ,right=1942 ,bottom=659 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='JOBSM', left=82, top=368, right=1929, bottom=651, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<T>id='직위' ,left=1304 ,top=90 ,right=1561 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='성명' ,left=1580 ,top=90 ,right=1918 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<X>left=344 ,top=1196 ,right=601 ,bottom=1270 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='OA 능력' ,left=355 ,top=1212 ,right=593 ,bottom=1257 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='TECH', left=609, top=1291, right=1937, bottom=1376, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=344 ,top=1270 ,right=601 ,bottom=1384 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='지식 / 기술' ,left=357 ,top=1275 ,right=595 ,bottom=1365 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=598 ,top=1270 ,right=1942 ,bottom=1270 </L>
	<L> left=601 ,top=1384 ,right=1945 ,bottom=1384 </L>
	<T>id='전공' ,left=1037 ,top=796 ,right=1275 ,bottom=847 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='{IF (EDU=1,\'고졸\',IF(EDU=4,\'초대졸\',IF(EDU=2,\'대졸\',\'대학원졸\')))}', left=606, top=799, right=982, bottom=847, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{IF (SEX=1,\'남\',IF(SEX=2,\'여\',\'무관\'))}', left=609, top=865, right=984, bottom=913, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=601 ,top=1196 ,right=1945 ,bottom=1196 </L>
	<X>left=344 ,top=1119 ,right=601 ,bottom=1196 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=601 ,top=1119 ,right=1945 ,bottom=1119 </L>
	<T>id='외국어 능력' ,left=355 ,top=1132 ,right=593 ,bottom=1183 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=601 ,top=1037 ,right=1945 ,bottom=1037 </L>
	<X>left=344 ,top=1037 ,right=601 ,bottom=1119 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=344 ,top=953 ,right=601 ,bottom=1037 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='해당분야 경험' ,left=349 ,top=971 ,right=587 ,bottom=1021 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='소요자격/면허증' ,left=347 ,top=1053 ,right=598 ,bottom=1103 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='CERTIFICATE', left=609, top=1045, right=1937, bottom=1111, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EXP', left=609, top=958, right=1937, bottom=1032, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FRGRD', left=609, top=1127, right=1937, bottom=1193, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='OAGRD', left=609, top=1201, right=1937, bottom=1267, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=74 ,top=1421 ,right=344 ,bottom=1640 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='소요교육' ,left=103 ,top=1548 ,right=307 ,bottom=1601 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='업무수행을 위한' ,left=82 ,top=1476 ,right=336 ,bottom=1529 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<L> left=601 ,top=1640 ,right=1945 ,bottom=1640 </L>
	<C>id='STUDY3', left=603, top=1577, right=1931, bottom=1635, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=344 ,top=1572 ,right=601 ,bottom=1640 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=344 ,top=1421 ,right=601 ,bottom=1495 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=344 ,top=1495 ,right=601 ,bottom=1572 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=601 ,top=1569 ,right=1945 ,bottom=1569 </L>
	<C>id='STUDY2', left=606, top=1500, right=1934, bottom=1564, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=601 ,top=1495 ,right=1945 ,bottom=1495 </L>
	<C>id='STUDY', left=606, top=1426, right=1934, bottom=1490, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='과정명' ,left=355 ,top=1437 ,right=593 ,bottom=1479 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='과정명' ,left=355 ,top=1508 ,right=593 ,bottom=1558 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='과정명' ,left=355 ,top=1585 ,right=593 ,bottom=1632 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='DPT_NM', left=542, top=175, right=881, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TEAM_NM', left=886, top=175, right=1291, bottom=222, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


</R>
</A>


<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132, PageSkip=true 
	<R>id='2쪽.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132,  DetailDataID='dsT_EV_JOBTASK',SuppressColumns='1:JOB'
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=264 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=74 ,top=196 ,right=1947 ,bottom=262 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=71 ,top=193 ,right=71 ,bottom=265 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1947 ,top=193 ,right=1947 ,bottom=265 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=71 ,top=193 ,right=1947 ,bottom=193 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=320 ,top=193 ,right=320 ,bottom=265 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='과업' ,left=328 ,top=198 ,right=654 ,bottom=262 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=659 ,top=193 ,right=659 ,bottom=265 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='과업 내용' ,left=664 ,top=198 ,right=1492 ,bottom=262 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='직무' ,left=79 ,top=198 ,right=315 ,bottom=262 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='비중' ,left=1508 ,top=198 ,right=1627 ,bottom=228 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='(%)' ,left=1508 ,top=230 ,right=1627 ,bottom=259 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<T>id='난이도' ,left=1635 ,top=198 ,right=1752 ,bottom=262 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<L> left=1630 ,top=193 ,right=1630 ,bottom=265 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1757 ,top=193 ,right=1757 ,bottom=265 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1500 ,top=193 ,right=1500 ,bottom=265 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='* 직무기술(수행업무)' ,left=79 ,top=114 ,right=915 ,bottom=177 ,align='left' ,face='굴림' ,size=11 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=77 ,top=265 ,right=1947 ,bottom=265 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='발생빈도' ,left=1762 ,top=198 ,right=1942 ,bottom=262 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=320 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1947 ,top=0 ,right=1947 ,bottom=320 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1500 ,top=0 ,right=1500 ,bottom=320 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1630 ,top=0 ,right=1630 ,bottom=320 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1757 ,top=0 ,right=1757 ,bottom=320 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='DEGREE', left=1635, top=130, right=1752, bottom=204, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='IMPORT', left=1508, top=130, right=1627, bottom=204, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FREQUENCY', left=1762, top=124, right=1942, bottom=209, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='JOB', left=79, top=5, right=318, bottom=315, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<L> left=71 ,top=0 ,right=323 ,bottom=0 ,supplevel=1 </L>
	<L> left=320 ,top=0 ,right=320 ,bottom=320 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=659 ,top=0 ,right=659 ,bottom=320 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='TASK', left=328, top=5, right=654, bottom=315, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<C>id='TASKDESC', left=664, top=5, right=1492, bottom=315, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>
	<L> left=320 ,top=0 ,right=1947 ,bottom=0 </L>
	<L> left=71 ,top=0 ,right=71 ,bottom=320 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=34 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=71 ,top=0 ,right=1947 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
</R>
</A>

">

</object>
</comment><script> __ShowEmbedObject(__NSID__); </script>



</body>
</html>

