<!--
    ************************************************************************************
    * @Source         : pira010.jsp                                                    		
    * @Description    : 인사기록정보 PAGE                                                	
    * @Developer Desc :                                                                		
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            	
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사											
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@page import ="Ehr.common.util.ImgUtil" %>
<%@ page import="Ehr.common.*" %>



<html>
<head>
<title>인사기록정보</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


<%
    Configuration conf = Configuration.getInstance();

    String FILEURL = conf.get("framework.file.download");
    
%>

    <!--
    ******************************************************
    * 자바스크립트 함수 선언부분
    ******************************************************
    -->
    <!-- 첨부 파일을 위해 -->
    <jsp:include page="../../../Ehr/common/fileupload.jsp" flush="true" />
    <!-- 첨부 파일을 위해 -->    
    
    
    <script language="javascript" >


        var imgBox  = null;        // 업로드된 사진 보여주기
        
        //var imgBox2  = null;       // 업로드된 사진 보여주기        

        var savflag = '';
        var ahiflag = '';

        //모달창으로 띄웠을 경우 구분하기 위해 사용
        var dsTemp = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	
            if (document.getElementById("txtENO_NO").value == "") {
                alert("사번/성명을 먼저 입력하신 다음 작업하여 주시기 바랍니다.");
                document.getElementById("txtENO_NM").focus();

                return;
            }

            
            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira010.cmd.PIRA010CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO").value;

            dsT_CM_PERSON.Reset();

            if (document.getElementById("txtENO_NO").disabled == false) {
                document.getElementById("txtENO_NM").focus();
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

            if(fnc_SaveItemCheck()) {

                trT_CM_PERSON.KeyValue = "SVL(I:SAV=dsT_CM_PERSON)";
                trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira010.cmd.PIRA010CMD&S_MODE=SAV&ENO_NO="+document.getElementById("txtENO_NO").value+"&HEAD_CD="+document.getElementById("txtHEAD_CD").value+"&DPT_CD="+document.getElementById("txtDPT_CD").value;
                trT_CM_PERSON.post();

				//입사후 경력 존재여부 확인
				ahiflag = 'SAV';
	            dsT_CM_AHISTORY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira025.cmd.PIRA025CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO").value;
	            dsT_CM_AHISTORY.Reset();

            }
            
            else {
                fnc_TabSave();
            }
            
        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

        
        
        /******************************************************************************
    		Description : 출력format
    	******************************************************************************/
    	function ln_Rpt_SetDataHeader(){ //출력물 데이타 셋헤드 생성
    		
    		var ls_temp = "";
    	
    		if (dsT_RP_REPORT00.countrow<1){
    			
    			dsT_RP_REPORT00.SetDataHeader(ls_temp);
    			
		        ls_temp1 = "ENO_NO:STRING(7),ENO_NM:STRING(20),NAM_CHI:STRING(20),NAM_ENG:STRING(20),BIR_YMD:STRING(10),AGE:STRING(5),BIR_TAG:STRING(5),"
		        + "MF_TAG:STRING(5),HIR_NM:STRING(20),OCC_NM:STRING(20),HIR_YMD:STRING(10),HIRG_YMD:STRING(10),JPR_YMD:STRING(10),HEAD_NM:STRING(20),"
		        + "DPT_NM:STRING(50),TEAM_NM:STRING(50),JOB_NM:STRING(20),HOB_NM:STRING(10),PER_ADR:STRING(100),RZI_NO:STRING(10),ADDRESS:STRING(100),"
		        + "PHN_NO:STRING(20),EM_PHN_NO:STRING(20),E_MAIL:STRING(50),TRG_NM:STRING(10),MPVA_NM:STRING(10),HOBBY:STRING(20),SPEC_CD:STRING(20),"
		        + "REL_NM:STRING(20),RET_YMD:STRING(10),LSE_YY:STRING(5), LSE_MM:STRING(10),EYE_LEF:STRING(5),EYE_RHT:STRING(5),HEIGHT:STRING(5),WEIGHT:STRING(5),BLD_TYP:STRING(5),"		        
		        + "GUB_NM:STRING(20),ENL_YMD:STRING(10),MIL_YMD:STRING(10), MIL_NM:STRING(10),GRADE:STRING(10),MBK_NM:STRING(10),"
		        
		        + "EDGR_NM1:STRING(20),GURE_YMD1:STRING(10),SCH_NAM1:STRING(10),MAJ_NM1:STRING(50),GRD_NM1:STRING(10),"	        
		        + "EDGR_NM2:STRING(20),GURE_YMD2:STRING(10),SCH_NAM2:STRING(10),MAJ_NM2:STRING(50),GRD_NM2:STRING(10),"
		        + "EDGR_NM3:STRING(20),GURE_YMD3:STRING(10),SCH_NAM3:STRING(10),MAJ_NM3:STRING(50),GRD_NM3:STRING(10),"
		        + "EDGR_NM4:STRING(20),GURE_YMD4:STRING(10),SCH_NAM4:STRING(10),MAJ_NM4:STRING(50),GRD_NM4:STRING(10),"        
		        + "EDGR_NM5:STRING(20),GURE_YMD5:STRING(10),SCH_NAM5:STRING(10),MAJ_NM5:STRING(50),GRD_NM5:STRING(10),"
		        + "EDGR_NM6:STRING(20),GURE_YMD6:STRING(10),SCH_NAM6:STRING(10),MAJ_NM6:STRING(50),GRD_NM6:STRING(10),"		        
		        + "QUA_NM1:STRING(50),GAN_YMD1:STRING(10),QUA_NO1:STRING(50),APP_ADM1:STRING(50),"	       
		        + "QUA_NM2:STRING(50),GAN_YMD2:STRING(10),QUA_NO2:STRING(50),APP_ADM2:STRING(50),"	
		        + "QUA_NM3:STRING(50),GAN_YMD3:STRING(10),QUA_NO3:STRING(50),APP_ADM3:STRING(50),"	
		        + "QUA_NM4:STRING(50),GAN_YMD4:STRING(10),QUA_NO4:STRING(50),APP_ADM4:STRING(50),"	
		        + "QUA_NM5:STRING(50),GAN_YMD5:STRING(10),QUA_NO5:STRING(50),APP_ADM5:STRING(50),"	
		        + "QUA_NM6:STRING(50),GAN_YMD6:STRING(10),QUA_NO6:STRING(50),APP_ADM6:STRING(50),"	
		        
		        + "REL_NM1:STRING(10),ENO_NM1:STRING(10),BIR_YMD1:STRING(20),EDGR_NAM1:STRING(20),OCC_NAM1:STRING(50),DPD_TAG1:STRING(2),HIU_TAG1:STRING(2),"	       
		        + "REL_NM2:STRING(10),ENO_NM2:STRING(10),BIR_YMD2:STRING(20),EDGR_NAM2:STRING(20),OCC_NAM2:STRING(50),DPD_TAG2:STRING(2),HIU_TAG2:STRING(2),"	
		        + "REL_NM3:STRING(10),ENO_NM3:STRING(10),BIR_YMD3:STRING(20),EDGR_NAM3:STRING(20),OCC_NAM3:STRING(50),DPD_TAG3:STRING(2),HIU_TAG3:STRING(2),"	       
		        + "REL_NM4:STRING(10),ENO_NM4:STRING(10),BIR_YMD4:STRING(20),EDGR_NAM4:STRING(20),OCC_NAM4:STRING(50),DPD_TAG4:STRING(2),HIU_TAG4:STRING(2),"		        
		        + "REL_NM5:STRING(10),ENO_NM5:STRING(10),BIR_YMD5:STRING(20),EDGR_NAM5:STRING(20),OCC_NAM5:STRING(50),DPD_TAG5:STRING(2),HIU_TAG5:STRING(2),"	    
		        + "REL_NM6:STRING(10),ENO_NM6:STRING(10),BIR_YMD6:STRING(20),EDGR_NAM6:STRING(20),OCC_NAM6:STRING(50),DPD_TAG6:STRING(2),HIU_TAG6:STRING(2),"		        
		        + "REL_NM7:STRING(10),ENO_NM7:STRING(10),BIR_YMD7:STRING(20),EDGR_NAM7:STRING(20),OCC_NAM7:STRING(50),DPD_TAG7:STRING(2),HIU_TAG7:STRING(2),"	 		        
		        + "REL_NM8:STRING(10),ENO_NM8:STRING(10),BIR_YMD8:STRING(20),EDGR_NAM8:STRING(20),OCC_NAM8:STRING(50),DPD_TAG8:STRING(2),HIU_TAG8:STRING(2),"      
		        
		        + "STR_YMD1:STRING(10),APP_NM1:STRING(10),JOB_NM1:STRING(20),DPT_NM1:STRING(100),TEAM_NM1:STRING(100),REMARK1:STRING(100),"	    		        
		        + "STR_YMD2:STRING(10),APP_NM2:STRING(10),JOB_NM2:STRING(20),DPT_NM2:STRING(100),TEAM_NM2:STRING(100),REMARK2:STRING(100),"			        
		        + "STR_YMD3:STRING(10),APP_NM3:STRING(10),JOB_NM3:STRING(20),DPT_NM3:STRING(100),TEAM_NM3:STRING(100),REMARK3:STRING(100),"		        
		        + "STR_YMD4:STRING(10),APP_NM4:STRING(10),JOB_NM4:STRING(20),DPT_NM4:STRING(100),TEAM_NM4:STRING(100),REMARK4:STRING(100),"	
		        + "STR_YMD5:STRING(10),APP_NM5:STRING(10),JOB_NM5:STRING(20),DPT_NM5:STRING(100),TEAM_NM5:STRING(100),REMARK5:STRING(100),"			        
		        + "STR_YMD6:STRING(10),APP_NM6:STRING(10),JOB_NM6:STRING(20),DPT_NM6:STRING(100),TEAM_NM6:STRING(100),REMARK6:STRING(100),"			        
		        + "STR_YMD7:STRING(10),APP_NM7:STRING(10),JOB_NM7:STRING(20),DPT_NM7:STRING(100),TEAM_NM7:STRING(100),REMARK7:STRING(100),"			        
		        + "STR_YMD8:STRING(10),APP_NM8:STRING(10),JOB_NM8:STRING(20),DPT_NM8:STRING(100),TEAM_NM8:STRING(100),REMARK8:STRING(100),"	    		        
		        + "STR_YMD9:STRING(10),APP_NM9:STRING(10),JOB_NM9:STRING(20),DPT_NM9:STRING(100),TEAM_NM9:STRING(100),REMARK9:STRING(100),"			        
		        + "STR_YMD10:STRING(10),APP_NM10:STRING(10),JOB_NM10:STRING(20),DPT_NM10:STRING(100),TEAM_NM10:STRING(100),REMARK10:STRING(100)," 
		        + "STR_YMD11:STRING(10),APP_NM11:STRING(10),JOB_NM11:STRING(20),DPT_NM11:STRING(100),TEAM_NM11:STRING(100),REMARK11:STRING(100),"	    		        
		        + "STR_YMD12:STRING(10),APP_NM12:STRING(10),JOB_NM12:STRING(20),DPT_NM12:STRING(100),TEAM_NM12:STRING(100),REMARK12:STRING(100),"			        
		        + "STR_YMD13:STRING(10),APP_NM13:STRING(10),JOB_NM13:STRING(20),DPT_NM13:STRING(100),TEAM_NM13:STRING(100),REMARK13:STRING(100),"		        
		        + "STR_YMD14:STRING(10),APP_NM14:STRING(10),JOB_NM14:STRING(20),DPT_NM14:STRING(100),TEAM_NM14:STRING(100),REMARK14:STRING(100),"	
		        + "STR_YMD15:STRING(10),APP_NM15:STRING(10),JOB_NM15:STRING(20),DPT_NM15:STRING(100),TEAM_NM15:STRING(100),REMARK15:STRING(100),"			        
		        + "STR_YMD16:STRING(10),APP_NM16:STRING(10),JOB_NM16:STRING(20),DPT_NM16:STRING(100),TEAM_NM16:STRING(100),REMARK16:STRING(100),"			        
		        + "STR_YMD17:STRING(10),APP_NM17:STRING(10),JOB_NM17:STRING(20),DPT_NM17:STRING(100),TEAM_NM17:STRING(100),REMARK17:STRING(100),"			        
		        + "STR_YMD18:STRING(10),APP_NM18:STRING(10),JOB_NM18:STRING(20),DPT_NM18:STRING(100),TEAM_NM18:STRING(100),REMARK18:STRING(100),"	    		        
		        + "STR_YMD19:STRING(10),APP_NM19:STRING(10),JOB_NM19:STRING(20),DPT_NM19:STRING(100),TEAM_NM19:STRING(100),REMARK19:STRING(100),"			        
		        + "STR_YMD20:STRING(10),APP_NM20:STRING(10),JOB_NM20:STRING(20),DPT_NM20:STRING(100),TEAM_NM20:STRING(100),REMARK20:STRING(100),"
		        + "STR_YMD21:STRING(10),APP_NM21:STRING(10),JOB_NM21:STRING(20),DPT_NM21:STRING(100),TEAM_NM21:STRING(100),REMARK21:STRING(100),"	    		        
		        + "STR_YMD22:STRING(10),APP_NM22:STRING(10),JOB_NM22:STRING(20),DPT_NM22:STRING(100),TEAM_NM22:STRING(100),REMARK22:STRING(100),"			        
		        + "STR_YMD23:STRING(10),APP_NM23:STRING(10),JOB_NM23:STRING(20),DPT_NM23:STRING(100),TEAM_NM23:STRING(100),REMARK23:STRING(100),"		        
		        + "STR_YMD24:STRING(10),APP_NM24:STRING(10),JOB_NM24:STRING(20),DPT_NM24:STRING(100),TEAM_NM24:STRING(100),REMARK24:STRING(100),"	
		        + "STR_YMD25:STRING(10),APP_NM25:STRING(10),JOB_NM25:STRING(20),DPT_NM25:STRING(100),TEAM_NM25:STRING(100),REMARK25:STRING(100),"			        
		        + "STR_YMD26:STRING(10),APP_NM26:STRING(10),JOB_NM26:STRING(20),DPT_NM26:STRING(100),TEAM_NM26:STRING(100),REMARK26:STRING(100),"			        
		        + "STR_YMD27:STRING(10),APP_NM27:STRING(10),JOB_NM27:STRING(20),DPT_NM27:STRING(100),TEAM_NM27:STRING(100),REMARK27:STRING(100),"			        
		        + "STR_YMD28:STRING(10),APP_NM28:STRING(10),JOB_NM28:STRING(20),DPT_NM28:STRING(100),TEAM_NM28:STRING(100),REMARK28:STRING(100),"	    		        
		        + "STR_YMD29:STRING(10),APP_NM29:STRING(10),JOB_NM29:STRING(20),DPT_NM29:STRING(100),TEAM_NM29:STRING(100),REMARK29:STRING(100),"			        
		        + "STR_YMD30:STRING(10),APP_NM30:STRING(10),JOB_NM30:STRING(20),DPT_NM30:STRING(100),TEAM_NM30:STRING(100),REMARK30:STRING(100),"
		        + "STR_YMD31:STRING(10),APP_NM31:STRING(10),JOB_NM31:STRING(20),DPT_NM31:STRING(100),TEAM_NM31:STRING(100),REMARK31:STRING(100),"	    		        
		        + "STR_YMD32:STRING(10),APP_NM32:STRING(10),JOB_NM32:STRING(20),DPT_NM32:STRING(100),TEAM_NM32:STRING(100),REMARK32:STRING(100),"			        
		        + "STR_YMD33:STRING(10),APP_NM33:STRING(10),JOB_NM33:STRING(20),DPT_NM33:STRING(100),TEAM_NM33:STRING(100),REMARK33:STRING(100),"		        
		        + "STR_YMD34:STRING(10),APP_NM34:STRING(10),JOB_NM34:STRING(20),DPT_NM34:STRING(100),TEAM_NM34:STRING(100),REMARK34:STRING(100),"	
		        + "STR_YMD35:STRING(10),APP_NM35:STRING(10),JOB_NM35:STRING(20),DPT_NM35:STRING(100),TEAM_NM35:STRING(100),REMARK35:STRING(100),"			        
		        + "STR_YMD36:STRING(10),APP_NM36:STRING(10),JOB_NM36:STRING(20),DPT_NM36:STRING(100),TEAM_NM36:STRING(100),REMARK36:STRING(100),"			        
		        + "STR_YMD37:STRING(10),APP_NM37:STRING(10),JOB_NM37:STRING(20),DPT_NM37:STRING(100),TEAM_NM37:STRING(100),REMARK37:STRING(100),"			        
		        + "STR_YMD38:STRING(10),APP_NM38:STRING(10),JOB_NM38:STRING(20),DPT_NM38:STRING(100),TEAM_NM38:STRING(100),REMARK38:STRING(100),"	    		        
		        + "STR_YMD39:STRING(10),APP_NM39:STRING(10),JOB_NM39:STRING(20),DPT_NM39:STRING(100),TEAM_NM39:STRING(100),REMARK39:STRING(100),"			        
		        + "STR_YMD40:STRING(10),APP_NM40:STRING(10),JOB_NM40:STRING(20),DPT_NM40:STRING(100),TEAM_NM40:STRING(100),REMARK40:STRING(100),"
		        + "STR_YMD41:STRING(10),APP_NM41:STRING(10),JOB_NM41:STRING(20),DPT_NM41:STRING(100),TEAM_NM41:STRING(100),REMARK41:STRING(100),"	    		        
		        + "STR_YMD42:STRING(10),APP_NM42:STRING(10),JOB_NM42:STRING(20),DPT_NM42:STRING(100),TEAM_NM42:STRING(100),REMARK42:STRING(100),"			        
		        + "STR_YMD43:STRING(10),APP_NM43:STRING(10),JOB_NM43:STRING(20),DPT_NM43:STRING(100),TEAM_NM43:STRING(100),REMARK43:STRING(100),"		        
		        + "STR_YMD44:STRING(10),APP_NM44:STRING(10),JOB_NM44:STRING(20),DPT_NM44:STRING(100),TEAM_NM44:STRING(100),REMARK44:STRING(100),"	
		        + "STR_YMD45:STRING(10),APP_NM45:STRING(10),JOB_NM45:STRING(20),DPT_NM45:STRING(100),TEAM_NM45:STRING(100),REMARK45:STRING(100),"			        
		        + "STR_YMD46:STRING(10),APP_NM46:STRING(10),JOB_NM46:STRING(20),DPT_NM46:STRING(100),TEAM_NM46:STRING(100),REMARK46:STRING(100),"			        
		        + "STR_YMD47:STRING(10),APP_NM47:STRING(10),JOB_NM47:STRING(20),DPT_NM47:STRING(100),TEAM_NM47:STRING(100),REMARK47:STRING(100),"			        
		        + "STR_YMD48:STRING(10),APP_NM48:STRING(10),JOB_NM48:STRING(20),DPT_NM48:STRING(100),TEAM_NM48:STRING(100),REMARK48:STRING(100),"	    		        
		        + "STR_YMD49:STRING(10),APP_NM49:STRING(10),JOB_NM49:STRING(20),DPT_NM49:STRING(100),TEAM_NM49:STRING(100),REMARK49:STRING(100),"			        
		        + "STR_YMD50:STRING(10),APP_NM50:STRING(10),JOB_NM50:STRING(20),DPT_NM50:STRING(100),TEAM_NM50:STRING(100),REMARK50:STRING(100)," 
		        + "STR_YMD51:STRING(10),APP_NM51:STRING(10),JOB_NM51:STRING(20),DPT_NM51:STRING(100),TEAM_NM51:STRING(100),REMARK51:STRING(100),"	    		        
		        + "STR_YMD52:STRING(10),APP_NM52:STRING(10),JOB_NM52:STRING(20),DPT_NM52:STRING(100),TEAM_NM52:STRING(100),REMARK52:STRING(100),"			        
		        + "STR_YMD53:STRING(10),APP_NM53:STRING(10),JOB_NM53:STRING(20),DPT_NM53:STRING(100),TEAM_NM53:STRING(100),REMARK53:STRING(100),"		        
		        + "STR_YMD54:STRING(10),APP_NM54:STRING(10),JOB_NM54:STRING(20),DPT_NM54:STRING(100),TEAM_NM54:STRING(100),REMARK54:STRING(100),"	
		        + "STR_YMD55:STRING(10),APP_NM55:STRING(10),JOB_NM55:STRING(20),DPT_NM55:STRING(100),TEAM_NM55:STRING(100),REMARK55:STRING(100),"			        
		        + "STR_YMD56:STRING(10),APP_NM56:STRING(10),JOB_NM56:STRING(20),DPT_NM56:STRING(100),TEAM_NM56:STRING(100),REMARK56:STRING(100),"			        
		        + "STR_YMD57:STRING(10),APP_NM57:STRING(10),JOB_NM57:STRING(20),DPT_NM57:STRING(100),TEAM_NM57:STRING(100),REMARK57:STRING(100),"			        
		        + "STR_YMD58:STRING(10),APP_NM58:STRING(10),JOB_NM58:STRING(20),DPT_NM58:STRING(100),TEAM_NM58:STRING(100),REMARK58:STRING(100),"	        
		        + "GUN_YM1:STRING(20),CMP_NAM1:STRING(50),DPT_NAM1:STRING(30),JOB_CD1:STRING(20),CHG_JOB1:STRING(100),"	    		        
		        + "GUN_YM2:STRING(20),CMP_NAM2:STRING(50),DPT_NAM2:STRING(30),JOB_CD2:STRING(20),CHG_JOB2:STRING(100),"	  
		        + "GUN_YM3:STRING(20),CMP_NAM3:STRING(50),DPT_NAM3:STRING(30),JOB_CD3:STRING(20),CHG_JOB3:STRING(100),"	    		        
		        + "GUN_YM4:STRING(20),CMP_NAM4:STRING(50),DPT_NAM4:STRING(30),JOB_CD4:STRING(20),CHG_JOB4:STRING(100),"	
		        + "GUN_YM5:STRING(20),CMP_NAM5:STRING(50),DPT_NAM5:STRING(30),JOB_CD5:STRING(20),CHG_JOB5:STRING(100),"	    		        
		        + "GUN_YM6:STRING(20),CMP_NAM6:STRING(50),DPT_NAM6:STRING(30),JOB_CD6:STRING(20),CHG_JOB6:STRING(100),"	  
		        + "GUN_YM7:STRING(20),CMP_NAM7:STRING(50),DPT_NAM7:STRING(30),JOB_CD7:STRING(20),CHG_JOB7:STRING(100),"	    		        
		        + "GUN_YM8:STRING(20),CMP_NAM8:STRING(50),DPT_NAM8:STRING(30),JOB_CD8:STRING(20),CHG_JOB8:STRING(100),"				
		        + "GUN_YM9:STRING(20),CMP_NAM9:STRING(50),DPT_NAM9:STRING(30),JOB_CD9:STRING(20),CHG_JOB9:STRING(100),"	    		        
		        + "GUN_YM10:STRING(20),CMP_NAM10:STRING(50),DPT_NAM10:STRING(30),JOB_CD10:STRING(20),CHG_JOB10:STRING(100),"	   
		        + "REPU_YMD1:STRING(20),REPU_TNM1:STRING(50),SYC_NAM1:STRING(30),REPU_RMK1:STRING(100),"
		        + "REPU_YMD2:STRING(20),REPU_TNM2:STRING(50),SYC_NAM2:STRING(30),REPU_RMK2:STRING(100),"
		        + "REPU_YMD3:STRING(20),REPU_TNM3:STRING(50),SYC_NAM3:STRING(30),REPU_RMK3:STRING(100),"
		        + "REPU_YMD4:STRING(20),REPU_TNM4:STRING(50),SYC_NAM4:STRING(30),REPU_RMK4:STRING(100),"
		        + "REPU_YMD5:STRING(20),REPU_TNM5:STRING(50),SYC_NAM5:STRING(30),REPU_RMK5:STRING(100),"
		        + "REPU_YMD6:STRING(20),REPU_TNM6:STRING(50),SYC_NAM6:STRING(30),REPU_RMK6:STRING(100),"
		        + "REPU_YMD7:STRING(20),REPU_TNM7:STRING(50),SYC_NAM7:STRING(30),REPU_RMK7:STRING(100),"        
		        + "EDU_YMD1:STRING(20),EDU_NM1:STRING(200),INT_NAM1:STRING(100),"
		        + "EDU_YMD2:STRING(20),EDU_NM2:STRING(200),INT_NAM2:STRING(100),"
		        + "EDU_YMD3:STRING(20),EDU_NM3:STRING(200),INT_NAM3:STRING(100),"
		        + "EDU_YMD4:STRING(20),EDU_NM4:STRING(200),INT_NAM4:STRING(100),"
		        + "EDU_YMD5:STRING(20),EDU_NM5:STRING(200),INT_NAM5:STRING(100),"
		        + "EDU_YMD6:STRING(20),EDU_NM6:STRING(200),INT_NAM6:STRING(100),"
		        + "EDU_YMD7:STRING(20),EDU_NM7:STRING(200),INT_NAM7:STRING(100),"
		        + "EDU_YMD8:STRING(20),EDU_NM8:STRING(200),INT_NAM8:STRING(100),"
		        + "EDU_YMD9:STRING(20),EDU_NM9:STRING(200),INT_NAM9:STRING(100),"
		        + "EDU_YMD10:STRING(20),EDU_NM10:STRING(200),INT_NAM10:STRING(100),"
		        + "EDU_YMD11:STRING(20),EDU_NM11:STRING(200),INT_NAM11:STRING(100),"
		        + "EDU_YMD12:STRING(20),EDU_NM12:STRING(200),INT_NAM12:STRING(100),"
		        + "EDU_YMD13:STRING(20),EDU_NM13:STRING(200),INT_NAM13:STRING(100),"
		        + "EDU_YMD14:STRING(20),EDU_NM14:STRING(200),INT_NAM14:STRING(100),"
		        + "EDU_YMD15:STRING(20),EDU_NM15:STRING(200),INT_NAM15:STRING(100),"
		        + "EDU_YMD16:STRING(20),EDU_NM16:STRING(200),INT_NAM16:STRING(100),"
		        + "EDU_YMD17:STRING(20),EDU_NM17:STRING(200),INT_NAM17:STRING(100),"
		        + "EDU_YMD18:STRING(20),EDU_NM18:STRING(200),INT_NAM18:STRING(100),"
		        + "EDU_YMD19:STRING(20),EDU_NM19:STRING(200),INT_NAM19:STRING(100)";	        
		        
		        
		        dsT_RP_REPORT00.SetDataHeader(ls_temp1);
		        
    		}
    	}
    
        
        
        
        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            var ENO_NO = document.getElementById('txtENO_NO').value;

            if (ENO_NO == "") {
                alert("사번을 입력하여 화면을 조회하신 후에 작업하시기 바랍니다.");
                return;
            }

            if (dsT_CM_PERSON.CountRow < 1) {
                alert("입력하신 사번으로 화면을 조회하신 후에 작업하시기 바랍니다.");
                return;
            }

            if (dsT_CM_PERSON.RowStatus(dsT_CM_PERSON.RowPosition) == 1) {
                alert("신규작업인 경우 화면을 먼저 저장하신 후에 작업하시기 바랍니다..");
                return;
            }
            
            //출력 직전에 작업을 돌린다.
    		dsT_RP_REPORT00.ClearAll();
    		dsT_RP_REPORT.ClearAll();
    		dsT_RP_REPORT2.ClearAll();    	
    		dsT_RP_REPORT3.ClearAll();   		
    		dsT_RP_REPORT4.ClearAll();   
    		dsT_RP_REPORT5.ClearAll();
    		
    		ln_Rpt_SetDataHeader();//데이타 셋헤드 

    		dsT_RP_REPORT00.addrow();

			//인사정보출력
            dsT_RP_REPORT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira010.cmd.PIRA010CMD"
																        		+"&S_MODE=SHR_PRINT"
																        		+"&ENO_NO="+ENO_NO;
			dsT_RP_REPORT.Reset();    

			//학력사항
            dsT_RP_REPORT2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira010.cmd.PIRA010CMD"
																        		+"&S_MODE=SHR_PRINT2"
																        		+"&ENO_NO="+ENO_NO;
			dsT_RP_REPORT2.Reset();    

			//자격증사항
            dsT_RP_REPORT3.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira010.cmd.PIRA010CMD"
																        		+"&S_MODE=SHR_PRINT3"
																        		+"&ENO_NO="+ENO_NO;
			dsT_RP_REPORT3.Reset();   

			//가족사항
            dsT_RP_REPORT4.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira010.cmd.PIRA010CMD"
																        		+"&S_MODE=SHR_PRINT4"
																        		+"&ENO_NO="+ENO_NO;
			dsT_RP_REPORT4.Reset();   			
			
			//입사후사항 
            dsT_RP_REPORT5.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira010.cmd.PIRA010CMD"
																        		+"&S_MODE=SHR_PRINT5"
																        		+"&ENO_NO="+ENO_NO;
			dsT_RP_REPORT5.Reset();  			
			
			//입사전사항 
            dsT_RP_REPORT6.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira010.cmd.PIRA010CMD"
																        		+"&S_MODE=SHR_PRINT6"
																        		+"&ENO_NO="+ENO_NO;
			dsT_RP_REPORT6.Reset();  			
			
			//상벌사항 
            dsT_RP_REPORT7.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira010.cmd.PIRA010CMD"
																        		+"&S_MODE=SHR_PRINT7"
																        		+"&ENO_NO="+ENO_NO;
			dsT_RP_REPORT7.Reset();  
			
			//교육사항
            dsT_RP_REPORT8.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira010.cmd.PIRA010CMD"
																        		+"&S_MODE=SHR_PRINT8"
																        		+"&ENO_NO="+ENO_NO;
			dsT_RP_REPORT8.Reset();  			
			
			dsT_RP_REPORT00.namevalue(1,"ENO_NO")       = dsT_RP_REPORT.namevalue(1,"ENO_NO");
			dsT_RP_REPORT00.namevalue(1,"ENO_NM")     = dsT_RP_REPORT.namevalue(1,"ENO_NM");
			dsT_RP_REPORT00.namevalue(1,"NAM_CHI")    = dsT_RP_REPORT.namevalue(1,"NAM_CHI");
			dsT_RP_REPORT00.namevalue(1,"NAM_ENG")   	= dsT_RP_REPORT.namevalue(1,"NAM_ENG");
			dsT_RP_REPORT00.namevalue(1,"BIR_YMD")   = dsT_RP_REPORT.namevalue(1,"BIR_YMD"); 
			dsT_RP_REPORT00.namevalue(1,"AGE")    = dsT_RP_REPORT.namevalue(1,"AGE");
			dsT_RP_REPORT00.namevalue(1,"BIR_TAG")    = dsT_RP_REPORT.namevalue(1,"BIR_TAG");
			dsT_RP_REPORT00.namevalue(1,"MF_TAG")    	= dsT_RP_REPORT.namevalue(1,"MF_TAG");					
			dsT_RP_REPORT00.namevalue(1,"HIR_NM")       = dsT_RP_REPORT.namevalue(1,"HIR_NM");
			dsT_RP_REPORT00.namevalue(1,"OCC_NM")     = dsT_RP_REPORT.namevalue(1,"OCC_NM");
			dsT_RP_REPORT00.namevalue(1,"HIR_YMD")    = dsT_RP_REPORT.namevalue(1,"HIR_YMD");
			dsT_RP_REPORT00.namevalue(1,"HIRG_YMD")   	= dsT_RP_REPORT.namevalue(1,"HIRG_YMD");
			dsT_RP_REPORT00.namevalue(1,"JPR_YMD")   = dsT_RP_REPORT.namevalue(1,"JPR_YMD"); 
			dsT_RP_REPORT00.namevalue(1,"HEAD_NM")    = dsT_RP_REPORT.namevalue(1,"HEAD_NM");
			dsT_RP_REPORT00.namevalue(1,"DPT_NM")    = dsT_RP_REPORT.namevalue(1,"DPT_NM");
			dsT_RP_REPORT00.namevalue(1,"TEAM_NM")    	= dsT_RP_REPORT.namevalue(1,"TEAM_NM");
			dsT_RP_REPORT00.namevalue(1,"JOB_NM")       = dsT_RP_REPORT.namevalue(1,"JOB_NM")
			dsT_RP_REPORT00.namevalue(1,"HOB_NM")     = dsT_RP_REPORT.namevalue(1,"HOB_NM");
			dsT_RP_REPORT00.namevalue(1,"PER_ADR")    = dsT_RP_REPORT.namevalue(1,"PER_ADR");
			dsT_RP_REPORT00.namevalue(1,"RZI_NO")   	= dsT_RP_REPORT.namevalue(1,"RZI_NO");
			dsT_RP_REPORT00.namevalue(1,"ADDRESS")   = dsT_RP_REPORT.namevalue(1,"ADDRESS"); 
			dsT_RP_REPORT00.namevalue(1,"PHN_NO")    = dsT_RP_REPORT.namevalue(1,"PHN_NO");
			dsT_RP_REPORT00.namevalue(1,"EM_PHN_NO")    = dsT_RP_REPORT.namevalue(1,"EM_PHN_NO");
			dsT_RP_REPORT00.namevalue(1,"E_MAIL")    	= dsT_RP_REPORT.namevalue(1,"E_MAIL");
			dsT_RP_REPORT00.namevalue(1,"TRG_NM")       = dsT_RP_REPORT.namevalue(1,"TRG_NM")
			
			//2016.07.27 JYS 수정
			//dsT_RP_REPORT00.namevalue(1,"ENO_NM")     = dsT_RP_REPORT.namevalue(1,"MPVA_NM");
            dsT_RP_REPORT00.namevalue(1,"MPVA_NM")     = dsT_RP_REPORT.namevalue(1,"MPVA_NM"); 

			dsT_RP_REPORT00.namevalue(1,"HOBBY")    = dsT_RP_REPORT.namevalue(1,"HOBBY");
			dsT_RP_REPORT00.namevalue(1,"SPEC_CD")   	= dsT_RP_REPORT.namevalue(1,"SPEC_CD");
			dsT_RP_REPORT00.namevalue(1,"REL_NM")   = dsT_RP_REPORT.namevalue(1,"REL_NM"); 
			dsT_RP_REPORT00.namevalue(1,"RET_YMD")    = dsT_RP_REPORT.namevalue(1,"RET_YMD");
			dsT_RP_REPORT00.namevalue(1,"LSE_YY")    = dsT_RP_REPORT.namevalue(1,"LSE_YY");
			dsT_RP_REPORT00.namevalue(1,"LSE_MM")    	= dsT_RP_REPORT.namevalue(1,"LSE_MM");			
			dsT_RP_REPORT00.namevalue(1,"EYE_LEF")       = dsT_RP_REPORT.namevalue(1,"EYE_LEF");
			dsT_RP_REPORT00.namevalue(1,"EYE_RHT")     = dsT_RP_REPORT.namevalue(1,"EYE_RHT");
			dsT_RP_REPORT00.namevalue(1,"HEIGHT")    = dsT_RP_REPORT.namevalue(1,"HEIGHT");
			dsT_RP_REPORT00.namevalue(1,"WEIGHT")   	= dsT_RP_REPORT.namevalue(1,"WEIGHT");
			dsT_RP_REPORT00.namevalue(1,"BLD_TYP")   = dsT_RP_REPORT.namevalue(1,"BLD_TYP"); 
			dsT_RP_REPORT00.namevalue(1,"GUB_NM")    = dsT_RP_REPORT.namevalue(1,"GUB_NM");
			dsT_RP_REPORT00.namevalue(1,"ENL_YMD")    = dsT_RP_REPORT.namevalue(1,"ENL_YMD");
			dsT_RP_REPORT00.namevalue(1,"MIL_YMD")    	= dsT_RP_REPORT.namevalue(1,"MIL_YMD");
			dsT_RP_REPORT00.namevalue(1,"MIL_NM")       = dsT_RP_REPORT.namevalue(1,"MIL_NM")
			dsT_RP_REPORT00.namevalue(1,"GRADE")     = dsT_RP_REPORT.namevalue(1,"GRADE");
			dsT_RP_REPORT00.namevalue(1,"MBK_NM")    = dsT_RP_REPORT.namevalue(1,"MBK_NM");
				
			
			for(i=1;i<=dsT_RP_REPORT2.countrow;i++){
		         
				dsT_RP_REPORT00.namevalue(1,"EDGR_NM"+i)   = dsT_RP_REPORT2.namevalue(i,"EDGR_NM");
				dsT_RP_REPORT00.namevalue(1,"GURE_YMD"+i)  = dsT_RP_REPORT2.namevalue(i,"GURE_YMD");
				dsT_RP_REPORT00.namevalue(1,"SCH_NAM"+i) = dsT_RP_REPORT2.namevalue(i,"SCH_NAM");
				dsT_RP_REPORT00.namevalue(1,"MAJ_NM"+i)   = dsT_RP_REPORT2.namevalue(i,"MAJ_NM");
				dsT_RP_REPORT00.namevalue(1,"GRD_NM"+i)  = dsT_RP_REPORT2.namevalue(i,"GRD_NM");

			}
			
			for(i=1;i<=dsT_RP_REPORT3.countrow;i++){
		         
				dsT_RP_REPORT00.namevalue(1,"QUA_NM"+i)   = dsT_RP_REPORT3.namevalue(i,"QUA_NM");
				dsT_RP_REPORT00.namevalue(1,"GAN_YMD"+i)  = dsT_RP_REPORT3.namevalue(i,"GAN_YMD");
				dsT_RP_REPORT00.namevalue(1,"QUA_NO"+i) = dsT_RP_REPORT3.namevalue(i,"QUA_NO");
				dsT_RP_REPORT00.namevalue(1,"APP_ADM"+i)   = dsT_RP_REPORT3.namevalue(i,"APP_ADM");

			}			
			
			
			for(i=1;i<=dsT_RP_REPORT4.countrow;i++){
		         
				dsT_RP_REPORT00.namevalue(1,"REL_NM"+i)   = dsT_RP_REPORT4.namevalue(i,"REL_NM");
				dsT_RP_REPORT00.namevalue(1,"ENO_NM"+i)  = dsT_RP_REPORT4.namevalue(i,"ENO_NM");
				dsT_RP_REPORT00.namevalue(1,"BIR_YMD"+i) = dsT_RP_REPORT4.namevalue(i,"BIR_YMD");
				dsT_RP_REPORT00.namevalue(1,"EDGR_NAM"+i)   = dsT_RP_REPORT4.namevalue(i,"EDGR_NAM");
				dsT_RP_REPORT00.namevalue(1,"OCC_NAM"+i)  = dsT_RP_REPORT4.namevalue(i,"OCC_NAM");
				dsT_RP_REPORT00.namevalue(1,"DPD_TAG"+i) = dsT_RP_REPORT4.namevalue(i,"DPD_TAG");
				dsT_RP_REPORT00.namevalue(1,"HIU_TAG"+i)   = dsT_RP_REPORT4.namevalue(i,"HIU_TAG");
				
			}					
			
			for(i=1;i<=dsT_RP_REPORT5.countrow;i++){
		         
				dsT_RP_REPORT00.namevalue(1,"STR_YMD"+i)   = dsT_RP_REPORT5.namevalue(i,"STR_YMD");
				dsT_RP_REPORT00.namevalue(1,"APP_NM"+i)  = dsT_RP_REPORT5.namevalue(i,"APP_NM");
				dsT_RP_REPORT00.namevalue(1,"JOB_NM"+i) = dsT_RP_REPORT5.namevalue(i,"JOB_NM");
				dsT_RP_REPORT00.namevalue(1,"DPT_NM"+i)   = dsT_RP_REPORT5.namevalue(i,"DPT_NM");
				dsT_RP_REPORT00.namevalue(1,"TEAM_NM"+i)  = dsT_RP_REPORT5.namevalue(i,"TEAM_NM");
				dsT_RP_REPORT00.namevalue(1,"REMARK"+i) = dsT_RP_REPORT5.namevalue(i,"REMARK");
				
			}					
			
			
			for(i=1;i<=dsT_RP_REPORT6.countrow;i++){
		         
				dsT_RP_REPORT00.namevalue(1,"GUN_YM"+i)   = dsT_RP_REPORT6.namevalue(i,"GUN_YM");
				dsT_RP_REPORT00.namevalue(1,"CMP_NAM"+i)  = dsT_RP_REPORT6.namevalue(i,"CMP_NAM");
				dsT_RP_REPORT00.namevalue(1,"DPT_NAM"+i) = dsT_RP_REPORT6.namevalue(i,"DPT_NAM");
				dsT_RP_REPORT00.namevalue(1,"JOB_CD"+i)   = dsT_RP_REPORT6.namevalue(i,"JOB_CD");
				dsT_RP_REPORT00.namevalue(1,"CHG_JOB"+i)  = dsT_RP_REPORT6.namevalue(i,"CHG_JOB");
				
			}				
			
			for(i=1;i<=dsT_RP_REPORT7.countrow;i++){
		         
				dsT_RP_REPORT00.namevalue(1,"REPU_YMD"+i)   = dsT_RP_REPORT7.namevalue(i,"REPU_YMD");
				dsT_RP_REPORT00.namevalue(1,"REPU_TNM"+i)  = dsT_RP_REPORT7.namevalue(i,"REPU_TNM");
				dsT_RP_REPORT00.namevalue(1,"SYC_NAM"+i) = dsT_RP_REPORT7.namevalue(i,"SYC_NAM");
				dsT_RP_REPORT00.namevalue(1,"REPU_RMK"+i)   = dsT_RP_REPORT7.namevalue(i,"REPU_RMK");
				
			}				
			
			for(i=1;i<=dsT_RP_REPORT8.countrow;i++){
		         
				dsT_RP_REPORT00.namevalue(1,"EDU_YMD"+i)   = dsT_RP_REPORT8.namevalue(i,"EDU_YMD");
				dsT_RP_REPORT00.namevalue(1,"EDU_NM"+i)  = dsT_RP_REPORT8.namevalue(i,"EDU_NM");
				dsT_RP_REPORT00.namevalue(1,"INT_NAM"+i) = dsT_RP_REPORT8.namevalue(i,"INT_NAM");
				
			}					
			

			ln_RptFormat(ENO_NO);

        }

        /******************************************************************************
        		Description :  출력물 포멧 작성
        ******************************************************************************/
        function ln_RptFormat(ENO_NO){   			
        			
        	var ls_for = "";

        	var gs_cdate = gcurdate.substring(0,4) + "/" + gcurdate.substring(5,7) + "/"+ gcurdate.substring(8,10);

        	var FILE_PHOTO = "<%=FILEURL%>" + "/" + ENO_NO + ".jpg";
        	
        	//alert(FILE_PHOTO);
        	
            //FILEURL = "<%=FILEURL%>" + "/" + ENO_NO + ".jpg";
        	//1번째
        	ls_for += "<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132";
            ls_for += "<R>id='1쪽.sbt' ,left=0 ,top=0 ,right=2871 ,bottom=132, MasterDataID='dsT_RP_REPORT00'";        	
        	ls_for += "<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=1897 ,face='Tahoma' ,size=10 ,penwidth=1";
        	ls_for += "<T>id='인 사 기 록 표 (1)' ,left=622 ,top=21 ,right=2199 ,bottom=114 ,face='Tahoma' ,size=26 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
        	ls_for += "<T>id='"+gs_cdate+"' ,left=2532 ,top=71 ,right=2820 ,bottom=132 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
        	ls_for += "<I>id='/../../../Ehr/photo/"+ENO_NO+".jpg' ,left=42 ,top=320 ,right=429 ,bottom=810</I>";  
 
        	//ls_for += "<I>id='"+FILE_PHOTO+"' ,left=42 ,top=320 ,right=429 ,bottom=810</I>";  
        	//ls_for += "<I>id='/../../../../../../../../asanwas/Ehr/file/"+ENO_NO+".jpg' ,left=42 ,top=320 ,right=429 ,bottom=810</I>";          	
        	
            //<img id="viewImage" src="init" border="0" width="125" height="167" onerror="this.src='../../images/common/none.jpg';">        	
        	
        	//ls_for += "<I>id='/asanwas/Ehr/file/"+ENO_NO+".jpg' ,left=42 ,top=320 ,right=429 ,bottom=810</I>"; 
        	//ls_for += "<I>id='"+FILE_PHOTO+"' ,left=42 ,top=320 ,right=429 ,bottom=810</I>";  
        	
        	//FILEURL = "<%=FILEURL%>" + "/" + ENO_NO + ".jpg";
        	//alert(ls_for);
        	
        	ls_for += "<T>id='출력일 :' ,left=2357 ,top=77 ,right=2516 ,bottom=124</T>";        	
        	ls_for += "<T>id='최종승진일' ,left=1185 ,top=151 ,right=1413 ,bottom=212</T>";
        	ls_for += "<T>id='그룹입사일' ,left=947 ,top=151 ,right=1175 ,bottom=212</T>";
        	ls_for += "<T>id='당사입사일' ,left=706 ,top=151 ,right=934 ,bottom=212</T>";
        	ls_for += "<T>id='근로구분' ,left=500 ,top=151 ,right=680 ,bottom=212</T>";
        	ls_for += "<T>id='채용구분' ,left=273 ,top=151 ,right=452 ,bottom=212</T>";
        	ls_for += "<T>id='사번' ,left=48 ,top=151 ,right=228 ,bottom=212</T>";
        	ls_for += "<L> left=21 ,top=1357 ,right=1421 ,bottom=1357 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1360 ,right=21 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1423 ,top=1357 ,right=1423 ,bottom=1855 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1857 ,right=1421 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=841 ,right=21 ,bottom=1339 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=511 ,top=841 ,right=511 ,bottom=1339 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=971 ,top=841 ,right=971 ,bottom=1339 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=778 ,top=841 ,right=778 ,bottom=1339 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=275 ,top=841 ,right=275 ,bottom=1339 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=93 ,top=913 ,right=1421 ,bottom=913 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=95 ,top=984 ,right=1423 ,bottom=984 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=93 ,top=1058 ,right=1421 ,bottom=1058 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=95 ,top=1130 ,right=1423 ,bottom=1130 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=93 ,top=1270 ,right=1421 ,bottom=1270 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=95 ,top=1199 ,right=1423 ,bottom=1199 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1339 ,right=1421 ,bottom=1339 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1423 ,top=841 ,right=1423 ,bottom=1339 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=841 ,right=1421 ,bottom=841 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=318 ,right=1421 ,bottom=318 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=818 ,right=1421 ,bottom=818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=320 ,right=21 ,bottom=818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=445 ,top=320 ,right=445 ,bottom=818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=442 ,top=389 ,right=1418 ,bottom=389 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=445 ,top=677 ,right=1421 ,bottom=677 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=445 ,top=606 ,right=1421 ,bottom=606 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=611 ,top=318 ,right=611 ,bottom=812 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=947 ,top=537 ,right=947 ,bottom=743 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1101 ,top=540 ,right=1101 ,bottom=746 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=947 ,top=318 ,right=947 ,bottom=466 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1098 ,top=318 ,right=1098 ,bottom=463 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=291 ,right=1421 ,bottom=291 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=217 ,right=1421 ,bottom=217 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1180 ,top=146 ,right=1180 ,bottom=291 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=939 ,top=146 ,right=939 ,bottom=291 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=479 ,top=146 ,right=479 ,bottom=291 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=249 ,top=146 ,right=249 ,bottom=291 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=146 ,right=1421 ,bottom=146 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='본 부' ,left=452 ,top=323 ,right=603 ,bottom=384</T>";
        	ls_for += "<T>id='소 속' ,left=452 ,top=397 ,right=603 ,bottom=458</T>";
        	ls_for += "<T>id='파 트' ,left=452 ,top=471 ,right=603 ,bottom=532</T>";
        	ls_for += "<T>id='성 명' ,left=452 ,top=542 ,right=603 ,bottom=603</T>";
        	ls_for += "<L> left=445 ,top=537 ,right=1421 ,bottom=537 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=445 ,top=466 ,right=1418 ,bottom=466 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1421 ,top=318 ,right=1421 ,bottom=815 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1421 ,top=146 ,right=1421 ,bottom=291 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='한 자' ,left=452 ,top=611 ,right=603 ,bottom=672</T>";
        	ls_for += "<T>id='영 문' ,left=452 ,top=683 ,right=603 ,bottom=743</T>";
        	ls_for += "<T>id='E-Mail' ,left=452 ,top=751 ,right=603 ,bottom=812</T>";
        	ls_for += "<L> left=701 ,top=146 ,right=701 ,bottom=291 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=445 ,top=746 ,right=1418 ,bottom=746 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='직 위' ,left=953 ,top=323 ,right=1093 ,bottom=384</T>";
        	ls_for += "<T>id='년 차' ,left=953 ,top=397 ,right=1093 ,bottom=458</T>";
        	ls_for += "<T>id='생년월일' ,left=953 ,top=542 ,right=1093 ,bottom=601</T>";
        	ls_for += "<T>id='만나이' ,left=953 ,top=611 ,right=1093 ,bottom=669</T>";
        	ls_for += "<T>id='성 별' ,left=955 ,top=683 ,right=1095 ,bottom=741</T>";
        	ls_for += "<T>id='학' ,left=32 ,top=913 ,right=82 ,bottom=971</T>";
        	ls_for += "<T>id='력' ,left=32 ,top=995 ,right=82 ,bottom=1053</T>";
        	ls_for += "<T>id='사' ,left=32 ,top=1122 ,right=82 ,bottom=1180</T>";
        	ls_for += "<T>id='항' ,left=32 ,top=1201 ,right=82 ,bottom=1259</T>";
        	ls_for += "<T>id='일 자' ,left=127 ,top=849 ,right=246 ,bottom=908</T>";
        	ls_for += "<T>id='학 교 명' ,left=294 ,top=849 ,right=497 ,bottom=908</T>";
        	ls_for += "<T>id='학력' ,left=545 ,top=849 ,right=749 ,bottom=908</T>";
        	ls_for += "<T>id='구분' ,left=788 ,top=849 ,right=960 ,bottom=908</T>";
        	ls_for += "<T>id='전 공' ,left=1103 ,top=849 ,right=1275 ,bottom=908</T>";
        	ls_for += "<L> left=93 ,top=841 ,right=93 ,bottom=1334 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=143 ,right=21 ,bottom=288 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=93 ,top=1360 ,right=93 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=95 ,top=1426 ,right=1423 ,bottom=1426 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=95 ,top=1638 ,right=1423 ,bottom=1638 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=93 ,top=1498 ,right=1421 ,bottom=1498 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=93 ,top=1569 ,right=1421 ,bottom=1569 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=95 ,top=1783 ,right=1423 ,bottom=1783 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=93 ,top=1709 ,right=1421 ,bottom=1709 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=418 ,top=1360 ,right=418 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=616 ,top=1360 ,right=616 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=955 ,top=1360 ,right=955 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='종 류' ,left=185 ,top=1363 ,right=344 ,bottom=1421</T>";
        	ls_for += "<T>id='취득일자' ,left=439 ,top=1363 ,right=598 ,bottom=1421</T>";
        	ls_for += "<T>id='발행처' ,left=704 ,top=1363 ,right=863 ,bottom=1421</T>";
        	ls_for += "<T>id='증서번호' ,left=1117 ,top=1363 ,right=1275 ,bottom=1421</T>";
        	ls_for += "<T>id='자' ,left=32 ,top=1442 ,right=82 ,bottom=1500</T>";
        	ls_for += "<T>id='격' ,left=32 ,top=1537 ,right=82 ,bottom=1595</T>";
        	ls_for += "<T>id='허' ,left=29 ,top=1717 ,right=79 ,bottom=1775</T>";
        	ls_for += "<T>id='면' ,left=29 ,top=1635 ,right=79 ,bottom=1693</T>";
        	ls_for += "<L> left=1439 ,top=146 ,right=1439 ,bottom=818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2839 ,top=146 ,right=2839 ,bottom=818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=146 ,right=2839 ,bottom=146 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1437 ,top=820 ,right=2836 ,bottom=820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1437 ,top=214 ,right=2836 ,bottom=214 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1617 ,top=148 ,right=1617 ,bottom=820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='본 적' ,left=1455 ,top=151 ,right=1606 ,bottom=212</T>";
        	ls_for += "<L> left=1437 ,top=616 ,right=2836 ,bottom=616 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=482 ,right=2839 ,bottom=482 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1617 ,top=278 ,right=2839 ,bottom=278 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1437 ,top=347 ,right=2836 ,bottom=347 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='주 소' ,left=1453 ,top=254 ,right=1603 ,bottom=315</T>";
        	ls_for += "<T>id='신체사항' ,left=1455 ,top=389 ,right=1606 ,bottom=450</T>";
        	ls_for += "<L> left=1619 ,top=410 ,right=2836 ,bottom=410 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1511 ,top=482 ,right=1511 ,bottom=614 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='병' ,left=1450 ,top=487 ,right=1500 ,bottom=545</T>";
        	ls_for += "<T>id='역' ,left=1450 ,top=553 ,right=1500 ,bottom=611</T>";
        	ls_for += "<T>id='구분' ,left=1516 ,top=487 ,right=1609 ,bottom=545</T>";
        	ls_for += "<T>id='군별' ,left=1519 ,top=556 ,right=1611 ,bottom=614</T>";
        	ls_for += "<T>id='특 기' ,left=1455 ,top=691 ,right=1598 ,bottom=749</T>";
        	ls_for += "<T>id='취 미' ,left=1455 ,top=624 ,right=1598 ,bottom=683</T>";
        	ls_for += "<T>id='종 교' ,left=1453 ,top=757 ,right=1595 ,bottom=815</T>";
        	ls_for += "<L> left=1921 ,top=482 ,right=1921 ,bottom=818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=685 ,right=1921 ,bottom=685 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=751 ,right=1921 ,bottom=751 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2032 ,top=688 ,right=2839 ,bottom=688 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2029 ,top=754 ,right=2836 ,bottom=754 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2029 ,top=619 ,right=2029 ,bottom=820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='종류' ,left=2037 ,top=624 ,right=2135 ,bottom=683</T>";
        	ls_for += "<T>id='성적' ,left=2037 ,top=693 ,right=2135 ,bottom=751</T>";
        	ls_for += "<T>id='연도' ,left=2037 ,top=757 ,right=2135 ,bottom=815</T>";
        	ls_for += "<T>id='어학' ,left=1926 ,top=659 ,right=2024 ,bottom=717</T>";
        	ls_for += "<T>id='성적' ,left=1926 ,top=728 ,right=2024 ,bottom=786</T>";
        	ls_for += "<T>id='계 급' ,left=1963 ,top=558 ,right=2103 ,bottom=611</T>";
        	ls_for += "<T>id='병 과' ,left=2418 ,top=558 ,right=2559 ,bottom=611</T>";
        	ls_for += "<T>id='복무기간' ,left=1939 ,top=489 ,right=2119 ,bottom=542</T>";
        	ls_for += "<L> left=2373 ,top=550 ,right=2373 ,bottom=818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='시 력' ,left=1783 ,top=352 ,right=1963 ,bottom=405</T>";
        	ls_for += "<L> left=2373 ,top=347 ,right=2373 ,bottom=479 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2601 ,top=349 ,right=2601 ,bottom=482 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='키' ,left=2167 ,top=355 ,right=2347 ,bottom=407</T>";
        	ls_for += "<T>id='몸무게' ,left=2402 ,top=355 ,right=2582 ,bottom=407</T>";
        	ls_for += "<T>id='혈액형' ,left=2633 ,top=352 ,right=2813 ,bottom=405</T>";
        	ls_for += "<L> left=2133 ,top=217 ,right=2133 ,bottom=275 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2138 ,top=349 ,right=2138 ,bottom=818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2463 ,top=217 ,right=2463 ,bottom=275 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2463 ,top=148 ,right=2463 ,bottom=212 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2350 ,top=148 ,right=2350 ,bottom=212 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2707 ,top=148 ,right=2707 ,bottom=212 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='보훈' ,left=2360 ,top=159 ,right=2458 ,bottom=206</T>";
        	ls_for += "<T>id='장애' ,left=2611 ,top=159 ,right=2701 ,bottom=206</T>";
        	ls_for += "<T>id='휴대폰' ,left=2471 ,top=222 ,right=2596 ,bottom=270</T>";
        	ls_for += "<L> left=1966 ,top=217 ,right=1966 ,bottom=275 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='전화번호' ,left=1979 ,top=222 ,right=2125 ,bottom=270</T>";
        	ls_for += "<L> left=1775 ,top=217 ,right=1775 ,bottom=278 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='우편번호' ,left=1625 ,top=222 ,right=1770 ,bottom=270</T>";
        	ls_for += "<L> left=1439 ,top=844 ,right=2839 ,bottom=844 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=847 ,right=1439 ,bottom=1519 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2839 ,top=844 ,right=2839 ,bottom=1516 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1437 ,top=1521 ,right=2836 ,bottom=1521 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1524 ,top=847 ,right=1524 ,bottom=1519 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1437 ,top=1558 ,right=2836 ,bottom=1558 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1558 ,right=1439 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1857 ,right=2839 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1709 ,right=2839 ,bottom=1709 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1437 ,top=1632 ,right=2836 ,bottom=1632 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1783 ,right=2839 ,bottom=1783 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2839 ,top=1558 ,right=2839 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2352 ,top=1632 ,right=2352 ,bottom=1855 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1685 ,top=1635 ,right=1685 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='퇴 직 사 항' ,left=1863 ,top=1569 ,right=2379 ,bottom=1622</T>";
        	ls_for += "<T>id='퇴직일자' ,left=1453 ,top=1646 ,right=1680 ,bottom=1699</T>";
        	ls_for += "<T>id='퇴직구분' ,left=1453 ,top=1720 ,right=1680 ,bottom=1773</T>";
        	ls_for += "<T>id='퇴직금' ,left=1453 ,top=1794 ,right=1680 ,bottom=1847</T>";
        	ls_for += "<T>id='근속년수' ,left=2119 ,top=1646 ,right=2347 ,bottom=1699</T>";
        	ls_for += "<L> left=2111 ,top=1635 ,right=2111 ,bottom=1857 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='사      유' ,left=2119 ,top=1717 ,right=2347 ,bottom=1770</T>";
        	ls_for += "<T>id='전 직 처' ,left=2119 ,top=1794 ,right=2347 ,bottom=1847</T>";
        	ls_for += "<L> left=1704 ,top=847 ,right=1704 ,bottom=1519 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1910 ,top=847 ,right=1910 ,bottom=1519 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2119 ,top=844 ,right=2119 ,bottom=1516 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2294 ,top=847 ,right=2294 ,bottom=1519 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='관계' ,left=1543 ,top=855 ,right=1683 ,bottom=908</T>";
        	ls_for += "<T>id='성명' ,left=1736 ,top=855 ,right=1876 ,bottom=908</T>";
        	ls_for += "<T>id='생년월일' ,left=1950 ,top=855 ,right=2090 ,bottom=908</T>";
        	ls_for += "<T>id='학 력' ,left=2138 ,top=855 ,right=2278 ,bottom=908</T>";
        	ls_for += "<T>id='근무처' ,left=2312 ,top=855 ,right=2609 ,bottom=908</T>";
        	ls_for += "<L> left=2617 ,top=847 ,right=2617 ,bottom=1519 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2733 ,top=844 ,right=2733 ,bottom=1516 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='의보' ,left=2627 ,top=855 ,right=2728 ,bottom=908</T>";
        	ls_for += "<T>id='부양' ,left=2738 ,top=855 ,right=2834 ,bottom=908</T>";
        	ls_for += "<L> left=1524 ,top=915 ,right=2839 ,bottom=915 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1524 ,top=984 ,right=2836 ,bottom=984 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1521 ,top=1135 ,right=2836 ,bottom=1135 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1521 ,top=1212 ,right=2839 ,bottom=1212 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1524 ,top=1365 ,right=2836 ,bottom=1365 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2836 ,top=1445 ,right=1524 ,bottom=1445 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='가' ,left=1455 ,top=990 ,right=1505 ,bottom=1048</T>";
        	ls_for += "<T>id='계' ,left=1458 ,top=1363 ,right=1508 ,bottom=1421</T>";
        	ls_for += "<T>id='족' ,left=1455 ,top=1080 ,right=1505 ,bottom=1138</T>";
        	ls_for += "<T>id='관' ,left=1458 ,top=1273 ,right=1508 ,bottom=1331</T>";
        	ls_for += "<L> left=1521 ,top=1289 ,right=2839 ,bottom=1289 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<C>id='HIR_NM', left=262, top=222, right=471, bottom=283</C>";
        	ls_for += "<C>id='ENO_NO', left=29, top=222, right=238, bottom=283</C>";
        	ls_for += "<C>id='TEAM_NM', left=619, top=471, right=1413, bottom=532, align='left', MargineX=3</C>";
        	ls_for += "<C>id='DPT_NM', left=616, top=397, right=939, bottom=458, align='left', MargineX=3</C>";
        	ls_for += "<C>id='HEAD_NM', left=616, top=323, right=939, bottom=384, align='left', MargineX=3</C>";
        	ls_for += "<C>id='JOB_NM', left=1103, top=323, right=1416, bottom=384, align='left', MargineX=3</C>";
        	ls_for += "<C>id='HOB_NM', left=1103, top=397, right=1416, bottom=458, align='left', MargineX=3</C>";
        	ls_for += "<C>id='NAM_CHI', left=619, top=611, right=828, bottom=669, align='left', MargineX=3</C>";
        	ls_for += "<C>id='ENO_NM', left=619, top=542, right=828, bottom=601, align='left', MargineX=3</C>";
        	ls_for += "<C>id='E_MAIL', left=619, top=751, right=1410, bottom=810, align='left', MargineX=3</C>";
        	ls_for += "<C>id='NAM_ENG', left=619, top=683, right=939, bottom=741, align='left', MargineX=3</C>";
        	ls_for += "<C>id='AGE', left=1106, top=614, right=1408, bottom=672</C>";
        	ls_for += "<C>id='MF_TAG', left=1106, top=683, right=1408, bottom=741</C>";
        	ls_for += "<C>id='BIR_TAG', left=1310, top=542, right=1408, bottom=601</C>";
        	ls_for += "<C>id='BIR_YMD', left=1106, top=542, right=1304, bottom=601</C>";
        	ls_for += "<C>id='OCC_NM', left=487, top=222, right=696, bottom=283</C>";
        	ls_for += "<C>id='HIR_YMD', left=720, top=222, right=929, bottom=283</C>";
        	ls_for += "<C>id='HIRG_YMD', left=958, top=222, right=1167, bottom=283</C>";
        	ls_for += "<C>id='JPR_YMD', left=1193, top=222, right=1402, bottom=283</C>";
        	ls_for += "<L> left=1513 ,top=548 ,right=2839 ,bottom=548 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1524 ,top=1058 ,right=2842 ,bottom=1058 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<C>id='RZI_NO', left=1783, top=220, right=1961, bottom=273</C>";
        	ls_for += "<C>id='PHN_NO', left=2138, top=220, right=2458, bottom=273</C>";
        	ls_for += "<L> left=2601 ,top=148 ,right=2601 ,bottom=275 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<C>id='EM_PHN_NO', left=2606, top=220, right=2834, bottom=273</C>";
        	ls_for += "<C>id='ADDRESS', left=1625, top=286, right=2834, bottom=339, align='left'</C>";
        	ls_for += "<C>id='PER_ADR', left=1625, top=153, right=2342, bottom=206, align='left'</C>";
        	ls_for += "<C>id='TRG_NM', left=2717, top=153, right=2831, bottom=206</C>";
        	ls_for += "<C>id='MPVA_NM', left=2477, top=153, right=2590, bottom=206</C>";
        	ls_for += "<C>id='EYE_RHT', left=1987, top=415, right=2101, bottom=468</C>";
        	ls_for += "<T>id='우 :' ,left=1892 ,top=418 ,right=1984 ,bottom=471</T>";
        	ls_for += "<C>id='EYE_LEF', left=1797, top=418, right=1881, bottom=471</C>";
        	ls_for += "<T>id='좌 :' ,left=1699 ,top=418 ,right=1791 ,bottom=471</T>";
        	ls_for += "<C>id='HEIGHT', left=2172, top=418, right=2342, bottom=471</C>";
        	ls_for += "<C>id='WEIGHT', left=2405, top=418, right=2574, bottom=471</C>";
        	ls_for += "<C>id='BLD_TYP', left=2635, top=418, right=2805, bottom=471</C>";
        	ls_for += "<L> left=2606 ,top=550 ,right=2606 ,bottom=820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<C>id='GUB_NM', left=1635, top=489, right=1905, bottom=542</C>";
        	ls_for += "<C>id='ENL_YMD', left=2170, top=489, right=2439, bottom=542, align='right'</C>";
        	ls_for += "<C>id='MIL_NM', left=1632, top=556, right=1902, bottom=609</C>";
        	ls_for += "<C>id='GRADE', left=2148, top=556, right=2368, bottom=609</C>";
        	ls_for += "<C>id='MBK_NM', left=2611, top=556, right=2831, bottom=609</C>";
        	ls_for += "<T>id='~' ,left=2442 ,top=489 ,right=2511 ,bottom=542</T>";
        	ls_for += "<C>id='MIL_YMD', left=2516, top=489, right=2786, bottom=542, align='left'</C>";
        	ls_for += "<C>id='SPEC_CD', left=1630, top=693, right=1900, bottom=746</C>";
        	ls_for += "<C>id='REL_NM', left=1630, top=759, right=1900, bottom=812</C>";
        	ls_for += "<C>id='HOBBY', left=1630, top=624, right=1900, bottom=677</C>";
        	ls_for += "<C>id='RET_YMD', left=1696, top=1643, right=2103, bottom=1696</C>";
        	ls_for += "<T>id='개월' ,left=2717 ,top=1643 ,right=2810 ,bottom=1701</T>";
        	ls_for += "<T>id='년' ,left=2535 ,top=1643 ,right=2585 ,bottom=1701</T>";
        	ls_for += "<C>id='LSE_YY', left=2371, top=1646, right=2529, bottom=1699, align='right'</C>";
        	ls_for += "<C>id='LSE_MM', left=2611, top=1643, right=2712, bottom=1696, align='right'</C>";
        	
        	ls_for += "<C>id='MAJ_NM1', left=976, top=921, right=1416, bottom=979</C>";
        	ls_for += "<C>id='MAJ_NM2', left=979, top=995, right=1418, bottom=1053</C>";
        	ls_for += "<C>id='MAJ_NM3', left=979, top=1066, right=1418, bottom=1124</C>";
        	ls_for += "<C>id='MAJ_NM4', left=976, top=1135, right=1416, bottom=1193</C>";
        	ls_for += "<C>id='MAJ_NM5', left=979, top=1204, right=1418, bottom=1262</C>";
        	ls_for += "<C>id='MAJ_NM6', left=979, top=1275, right=1418, bottom=1334</C>";
        	ls_for += "<C>id='SCH_NAM1', left=280, top=918, right=505, bottom=976</C>";
        	ls_for += "<C>id='SCH_NAM2', left=280, top=992, right=505, bottom=1050</C>";
        	ls_for += "<C>id='SCH_NAM3', left=280, top=1066, right=505, bottom=1124</C>";
        	ls_for += "<C>id='SCH_NAM4', left=280, top=1138, right=505, bottom=1196</C>";
        	ls_for += "<C>id='SCH_NAM5', left=280, top=1204, right=505, bottom=1262</C>";
        	ls_for += "<C>id='SCH_NAM6', left=280, top=1275, right=505, bottom=1334</C>";
        	ls_for += "<C>id='EDGR_NM1', left=516, top=921, right=770, bottom=979</C>";
        	ls_for += "<C>id='EDGR_NM2', left=516, top=995, right=770, bottom=1053</C>";
        	ls_for += "<C>id='EDGR_NM3', left=519, top=1066, right=773, bottom=1124</C>";
        	ls_for += "<C>id='EDGR_NM4', left=516, top=1138, right=770, bottom=1196</C>";
        	ls_for += "<C>id='EDGR_NM5', left=516, top=1207, right=770, bottom=1265</C>";
        	ls_for += "<C>id='EDGR_NM6', left=519, top=1275, right=773, bottom=1334</C>";
        	ls_for += "<C>id='GRD_NM1', left=783, top=921, right=966, bottom=979</C>";
        	ls_for += "<C>id='GRD_NM2', left=783, top=992, right=966, bottom=1050</C>";
        	ls_for += "<C>id='GRD_NM3', left=783, top=1066, right=966, bottom=1124</C>";
        	ls_for += "<C>id='GRD_NM4', left=783, top=1138, right=966, bottom=1196</C>";
        	ls_for += "<C>id='GRD_NM5', left=783, top=1207, right=966, bottom=1265</C>";
        	ls_for += "<C>id='GRD_NM6', left=783, top=1275, right=966, bottom=1334</C>";
        	ls_for += "<C>id='GURE_YMD1', left=101, top=921, right=270, bottom=979</C>";
        	ls_for += "<C>id='GURE_YMD2', left=101, top=992, right=270, bottom=1050</C>";
        	ls_for += "<C>id='GURE_YMD3', left=101, top=1066, right=270, bottom=1124</C>";
        	ls_for += "<C>id='GURE_YMD4', left=101, top=1135, right=270, bottom=1193</C>";
        	ls_for += "<C>id='GURE_YMD5', left=98, top=1207, right=267, bottom=1265</C>";
        	ls_for += "<C>id='GURE_YMD6', left=98, top=1275, right=267, bottom=1334</C>";        	
        	
        	ls_for += "<C>id='QUA_NM1', left=101, top=1434, right=410, bottom=1492</C>";
        	ls_for += "<C>id='QUA_NM2', left=101, top=1505, right=410, bottom=1564</C>";
        	ls_for += "<C>id='QUA_NM3', left=101, top=1577, right=410, bottom=1635</C>";
        	ls_for += "<C>id='QUA_NM4', left=101, top=1646, right=410, bottom=1704</C>";
        	ls_for += "<C>id='QUA_NM5', left=101, top=1717, right=410, bottom=1775</C>";
        	ls_for += "<C>id='QUA_NM6', left=101, top=1791, right=410, bottom=1849</C>";
        	ls_for += "<C>id='GAN_YMD1', left=426, top=1434, right=611, bottom=1492</C>";
        	ls_for += "<C>id='GAN_YMD2', left=426, top=1505, right=611, bottom=1564</C>";
        	ls_for += "<C>id='GAN_YMD3', left=426, top=1577, right=611, bottom=1635</C>";
        	ls_for += "<C>id='GAN_YMD4', left=426, top=1646, right=611, bottom=1704</C>";
        	ls_for += "<C>id='GAN_YMD5', left=426, top=1717, right=611, bottom=1775</C>";
        	ls_for += "<C>id='GAN_YMD6', left=426, top=1791, right=611, bottom=1849</C>";
        	ls_for += "<C>id='APP_ADM1', left=622, top=1434, right=950, bottom=1492</C>";
        	ls_for += "<C>id='APP_ADM2', left=624, top=1505, right=953, bottom=1564</C>";
        	ls_for += "<C>id='APP_ADM3', left=622, top=1577, right=950, bottom=1635</C>";
        	ls_for += "<C>id='APP_ADM4', left=622, top=1646, right=950, bottom=1704</C>";
        	ls_for += "<C>id='APP_ADM5', left=622, top=1717, right=950, bottom=1775</C>";
        	ls_for += "<C>id='APP_ADM6', left=622, top=1791, right=950, bottom=1849</C>";
        	ls_for += "<C>id='QUA_NO1', left=963, top=1434, right=1416, bottom=1492</C>";
        	ls_for += "<C>id='QUA_NO2', left=963, top=1505, right=1416, bottom=1564</C>";
        	ls_for += "<C>id='QUA_NO4', left=963, top=1646, right=1416, bottom=1704</C>";
        	ls_for += "<C>id='QUA_NO3', left=963, top=1577, right=1416, bottom=1635</C>";
        	ls_for += "<C>id='QUA_NO5', left=963, top=1717, right=1416, bottom=1775</C>";
        	ls_for += "<C>id='QUA_NO6', left=963, top=1791, right=1416, bottom=1849</C>";        	
        	
        	ls_for += "<C>id='REL_NM1', left=1529, top=921, right=1699, bottom=979</C>";
        	ls_for += "<C>id='REL_NM2', left=1529, top=992, right=1699, bottom=1050</C>";
        	ls_for += "<C>id='REL_NM3', left=1529, top=1069, right=1699, bottom=1127</C>";
        	ls_for += "<C>id='REL_NM4', left=1529, top=1146, right=1699, bottom=1204</C>";
        	ls_for += "<C>id='REL_NM5', left=1529, top=1222, right=1699, bottom=1281</C>";
        	ls_for += "<C>id='REL_NM6', left=1529, top=1299, right=1699, bottom=1357</C>";
        	ls_for += "<C>id='REL_NM7', left=1529, top=1376, right=1699, bottom=1434</C>";
        	ls_for += "<C>id='REL_NM8', left=1529, top=1455, right=1699, bottom=1513</C>";
        	ls_for += "<C>id='ENO_NM1', left=1709, top=921, right=1905, bottom=979</C>";
        	ls_for += "<C>id='ENO_NM2', left=1709, top=992, right=1905, bottom=1050</C>";
        	ls_for += "<C>id='ENO_NM3', left=1709, top=1069, right=1905, bottom=1127</C>";
        	ls_for += "<C>id='ENO_NM4', left=1709, top=1146, right=1905, bottom=1204</C>";
        	ls_for += "<C>id='ENO_NM5', left=1709, top=1222, right=1905, bottom=1281</C>";
        	ls_for += "<C>id='ENO_NM6', left=1709, top=1299, right=1905, bottom=1357</C>";
        	ls_for += "<C>id='ENO_NM7', left=1709, top=1376, right=1905, bottom=1434</C>";
        	ls_for += "<C>id='ENO_NM8', left=1709, top=1453, right=1905, bottom=1511</C>";
        	ls_for += "<C>id='BIR_YMD1', left=1916, top=921, right=2114, bottom=979</C>";
        	ls_for += "<C>id='BIR_YMD2', left=1916, top=992, right=2114, bottom=1050</C>";
        	ls_for += "<C>id='BIR_YMD3', left=1916, top=1069, right=2114, bottom=1127</C>";
        	ls_for += "<C>id='BIR_YMD4', left=1916, top=1146, right=2114, bottom=1204</C>";
        	ls_for += "<C>id='BIR_YMD5', left=1916, top=1222, right=2114, bottom=1281</C>";
        	ls_for += "<C>id='BIR_YMD6', left=1916, top=1299, right=2114, bottom=1357</C>";
        	ls_for += "<C>id='BIR_YMD7', left=1916, top=1373, right=2114, bottom=1431</C>";
        	ls_for += "<C>id='BIR_YMD8', left=1916, top=1453, right=2114, bottom=1511</C>";
        	ls_for += "<C>id='EDGR_NAM1', left=2125, top=921, right=2291, bottom=979</C>";
        	ls_for += "<C>id='EDGR_NAM2', left=2125, top=992, right=2291, bottom=1050</C>";
        	ls_for += "<C>id='EDGR_NAM3', left=2125, top=1069, right=2291, bottom=1127</C>";
        	ls_for += "<C>id='EDGR_NAM4', left=2125, top=1146, right=2291, bottom=1204</C>";
        	ls_for += "<C>id='EDGR_NAM5', left=2125, top=1222, right=2291, bottom=1281</C>";
        	ls_for += "<C>id='EDGR_NAM6', left=2125, top=1299, right=2291, bottom=1357</C>";
        	ls_for += "<C>id='EDGR_NAM7', left=2125, top=1376, right=2291, bottom=1434</C>";
        	ls_for += "<C>id='EDGR_NAM8', left=2125, top=1455, right=2291, bottom=1513</C>";
        	ls_for += "<C>id='OCC_NAM1', left=2302, top=921, right=2609, bottom=979</C>";
        	ls_for += "<C>id='OCC_NAM2', left=2302, top=995, right=2609, bottom=1053</C>";
        	ls_for += "<C>id='OCC_NAM3', left=2302, top=1069, right=2609, bottom=1127</C>";
        	ls_for += "<C>id='OCC_NAM4', left=2302, top=1146, right=2609, bottom=1204</C>";
        	ls_for += "<C>id='OCC_NAM5', left=2302, top=1222, right=2609, bottom=1281</C>";
        	ls_for += "<C>id='OCC_NAM6', left=2302, top=1299, right=2609, bottom=1357</C>";
        	ls_for += "<C>id='OCC_NAM8', left=2302, top=1453, right=2609, bottom=1511</C>";
        	ls_for += "<C>id='OCC_NAM7', left=2302, top=1373, right=2609, bottom=1431</C>";
        	ls_for += "<C>id='HIU_TAG1', left=2622, top=921, right=2731, bottom=979</C>";
        	ls_for += "<C>id='HIU_TAG2', left=2622, top=995, right=2731, bottom=1053</C>";
        	ls_for += "<C>id='HIU_TAG3', left=2622, top=1069, right=2731, bottom=1127</C>";
        	ls_for += "<C>id='HIU_TAG4', left=2622, top=1146, right=2731, bottom=1204</C>";
        	ls_for += "<C>id='HIU_TAG5', left=2622, top=1222, right=2731, bottom=1281</C>";
        	ls_for += "<C>id='HIU_TAG6', left=2622, top=1299, right=2731, bottom=1357</C>";
        	ls_for += "<C>id='HIU_TAG7', left=2622, top=1376, right=2731, bottom=1434</C>";
        	ls_for += "<C>id='HIU_TAG8', left=2622, top=1455, right=2731, bottom=1513</C>";
        	ls_for += "<C>id='DPD_TAG1', left=2738, top=921, right=2834, bottom=979</C>";
        	ls_for += "<C>id='DPD_TAG2', left=2738, top=995, right=2834, bottom=1053</C>";
        	ls_for += "<C>id='DPD_TAG3', left=2738, top=1069, right=2834, bottom=1127</C>";
        	ls_for += "<C>id='DPD_TAG4', left=2738, top=1146, right=2834, bottom=1204</C>";
        	ls_for += "<C>id='DPD_TAG5', left=2738, top=1222, right=2834, bottom=1281</C>";
        	ls_for += "<C>id='DPD_TAG6', left=2738, top=1296, right=2834, bottom=1355</C>";
        	ls_for += "<C>id='DPD_TAG8', left=2738, top=1455, right=2834, bottom=1513</C>";
        	ls_for += "<C>id='DPD_TAG7', left=2738, top=1373, right=2834, bottom=1431</C>";        	
        	ls_for += "<I>id='../../../Common/img/icon.jpg' ,left=2471 ,top=1880 ,right=2823 ,bottom=1960</I>";   
        	ls_for += "</B>";
        	ls_for += "</R>";
            ls_for += "</A>";
        	
        	
            
            
            //2 page
        	ls_for += "<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132";
            ls_for += "<R>id='2쪽.sbt' ,left=0 ,top=0 ,right=2871 ,bottom=132, MasterDataID='dsT_RP_REPORT00'";        
            
        	ls_for += "<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=1926 ,face='Tahoma' ,size=10 ,penwidth=1";
        	ls_for += "<T>id='인 사 기 록 표 (2)' ,left=622 ,top=21 ,right=2199 ,bottom=114 ,face='Tahoma' ,size=26 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
        	ls_for += "<T>id='출력일 :' ,left=2357 ,top=77 ,right=2516 ,bottom=124</T>";
           	ls_for += "<T>id='"+gs_cdate+"' ,left=2532 ,top=71 ,right=2820 ,bottom=132 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
        	ls_for += "<L> left=21 ,top=291 ,right=1421 ,bottom=291 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=217 ,right=1421 ,bottom=217 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=146 ,right=1421 ,bottom=146 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=146 ,right=21 ,bottom=1082 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1876 ,right=1421 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='입 사 전 경 력 사 항' ,left=48 ,top=151 ,right=1386 ,bottom=212</T>";
        	ls_for += "<T>id='교육 사 항' ,left=1466 ,top=151 ,right=2805 ,bottom=212</T>";
        	ls_for += "<T>id='기 간' ,left=1540 ,top=225 ,right=1720 ,bottom=286</T>";        	

        	ls_for += "<T>id='근 무 기 간 ' ,left=42 ,top=225 ,right=368 ,bottom=286</T>"; 	
            ls_for += "<T>id='직 장 명' ,left=471 ,top=225 ,right=699 ,bottom=286</T>"; 
            ls_for += "<T>id='직위' ,left=884 ,top=225 ,right=1064 ,bottom=286</T>"; 
            ls_for += "<T>id='담당업무' ,left=1151 ,top=225 ,right=1360 ,bottom=286</T>";        	

        	ls_for += "<L> left=376 ,top=217 ,right=376 ,bottom=1080 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1421 ,top=146 ,right=1421 ,bottom=1082 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=839 ,top=217 ,right=839 ,bottom=1080 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";

        	ls_for += "<L> left=21 ,top=365 ,right=1421 ,bottom=365 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=437 ,right=1421 ,bottom=437 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=513 ,right=1421 ,bottom=513 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=593 ,right=1421 ,bottom=593 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=672 ,right=1421 ,bottom=672 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=751 ,right=1421 ,bottom=751 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=836 ,right=1421 ,bottom=836 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=915 ,right=1421 ,bottom=915 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=997 ,right=1421 ,bottom=997 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1082 ,right=1421 ,bottom=1082 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1167 ,right=1421 ,bottom=1167 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=119 ,top=1251 ,right=1421 ,bottom=1251 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=119 ,top=1341 ,right=1421 ,bottom=1341 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=119 ,top=1426 ,right=1421 ,bottom=1426 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=119 ,top=1516 ,right=1421 ,bottom=1516 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=119 ,top=1603 ,right=1421 ,bottom=1603 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=119 ,top=1699 ,right=1421 ,bottom=1699 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=119 ,top=1789 ,right=1421 ,bottom=1789 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=291 ,right=2839 ,bottom=291 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=217 ,right=2839 ,bottom=217 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=146 ,right=2839 ,bottom=146 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=146 ,right=1439 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1876 ,right=2839 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";

        	ls_for += "<L> left=2839 ,top=146 ,right=2839 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1834 ,top=220 ,right=1834 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2439 ,top=217 ,right=2439 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=365 ,right=2839 ,bottom=365 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=437 ,right=2839 ,bottom=437 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=513 ,right=2839 ,bottom=513 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=593 ,right=2839 ,bottom=593 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=672 ,right=2839 ,bottom=672 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=751 ,right=2839 ,bottom=751 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=836 ,right=2839 ,bottom=836 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=915 ,right=2839 ,bottom=915 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=997 ,right=2839 ,bottom=997 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1082 ,right=2839 ,bottom=1082 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1167 ,right=2839 ,bottom=1167 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1251 ,right=2839 ,bottom=1251 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1341 ,right=2839 ,bottom=1341 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1426 ,right=2839 ,bottom=1426 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1516 ,right=2839 ,bottom=1516 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1603 ,right=2839 ,bottom=1603 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1699 ,right=2839 ,bottom=1699 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1439 ,top=1786 ,right=2839 ,bottom=1786 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='과 정 명' ,left=1955 ,top=225 ,right=2305 ,bottom=286</T>";
        	ls_for += "<T>id='시 행 처' ,left=2469 ,top=225 ,right=2831 ,bottom=286</T>";

        	ls_for += "<L> left=1085 ,top=217 ,right=1085 ,bottom=1082 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1167 ,right=21 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=119 ,top=1169 ,right=119 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<T>id='상' ,left=37 ,top=1265 ,right=103 ,bottom=1326</T>";
        	ls_for += "<T>id='벌' ,left=37 ,top=1389 ,right=103 ,bottom=1450</T>";
        	ls_for += "<T>id='사' ,left=37 ,top=1564 ,right=103 ,bottom=1625</T>";
        	ls_for += "<T>id='항' ,left=37 ,top=1670 ,right=103 ,bottom=1730</T>";

        	ls_for += "<C>id='CMP_NAM1', left=384, top=296, right=828, bottom=360</C>";
        	ls_for += "<C>id='CMP_NAM2', left=384, top=370, right=828, bottom=434</C>";
        	ls_for += "<C>id='CMP_NAM3', left=384, top=442, right=828, bottom=505</C>";
        	ls_for += "<C>id='CMP_NAM4', left=384, top=521, right=828, bottom=585</C>";
        	ls_for += "<C>id='CMP_NAM5', left=384, top=598, right=828, bottom=661</C>";
        	ls_for += "<C>id='CMP_NAM6', left=384, top=677, right=828, bottom=741</C>";
        	ls_for += "<C>id='CMP_NAM7', left=384, top=762, right=828, bottom=826</C>";
        	ls_for += "<C>id='CMP_NAM8', left=384, top=847, right=828, bottom=910</C>";
        	ls_for += "<C>id='CMP_NAM9', left=384, top=923, right=828, bottom=987</C>";
        	ls_for += "<C>id='CMP_NAM10', left=384, top=1008, right=828, bottom=1072</C>";

        	ls_for += "<C>id='JOB_CD1', left=844, top=296, right=1080, bottom=360</C>";
        	ls_for += "<C>id='JOB_CD2', left=844, top=370, right=1080, bottom=434</C>";
        	ls_for += "<C>id='JOB_CD3', left=844, top=442, right=1080, bottom=505</C>";
        	ls_for += "<C>id='JOB_CD4', left=844, top=521, right=1080, bottom=585</C>";
        	ls_for += "<C>id='JOB_CD5', left=844, top=598, right=1080, bottom=661</C>";
        	ls_for += "<C>id='JOB_CD6', left=844, top=677, right=1080, bottom=741</C>";
        	ls_for += "<C>id='JOB_CD7', left=844, top=762, right=1080, bottom=826</C>";
        	ls_for += "<C>id='JOB_CD8', left=844, top=844, right=1080, bottom=908</C>";
        	ls_for += "<C>id='JOB_CD9', left=844, top=926, right=1080, bottom=990</C>";
        	ls_for += "<C>id='JOB_CD10', left=844, top=1008, right=1080, bottom=1072</C>";

        	ls_for += "<C>id='GUN_YM1', left=29, top=296, right=368, bottom=360</C>";
        	ls_for += "<C>id='GUN_YM2', left=29, top=368, right=368, bottom=431</C>";
        	ls_for += "<C>id='GUN_YM3', left=29, top=442, right=368, bottom=505</C>";
        	ls_for += "<C>id='GUN_YM4', left=29, top=519, right=368, bottom=582</C>";
        	ls_for += "<C>id='GUN_YM5', left=29, top=598, right=368, bottom=661</C>";
        	ls_for += "<C>id='GUN_YM6', left=29, top=677, right=368, bottom=741</C>";
        	ls_for += "<C>id='GUN_YM7', left=29, top=759, right=368, bottom=823</C>";
        	ls_for += "<C>id='GUN_YM8', left=29, top=844, right=368, bottom=908</C>";
        	ls_for += "<C>id='GUN_YM9', left=29, top=923, right=368, bottom=987</C>";
        	ls_for += "<C>id='GUN_YM10', left=29, top=1008, right=368, bottom=1072</C>";

        	ls_for += "<C>id='CHG_JOB1', left=1087, top=296, right=1413, bottom=360, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='CHG_JOB2', left=1087, top=368, right=1413, bottom=431, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='CHG_JOB3', left=1087, top=442, right=1413, bottom=505, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='CHG_JOB4', left=1087, top=521, right=1413, bottom=585, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='CHG_JOB5', left=1087, top=598, right=1413, bottom=661, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='CHG_JOB6', left=1087, top=677, right=1413, bottom=741, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='CHG_JOB7', left=1087, top=759, right=1413, bottom=823, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='CHG_JOB8', left=1087, top=844, right=1413, bottom=908, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='CHG_JOB9', left=1087, top=926, right=1413, bottom=990, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='CHG_JOB10', left=1087, top=1008, right=1413, bottom=1072, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";

        	ls_for += "<T>id='날 짜' ,left=146 ,top=1177 ,right=325 ,bottom=1238</T>";
        	ls_for += "<T>id='상 벌 명' ,left=407 ,top=1180 ,right=630 ,bottom=1241</T>";
        	ls_for += "<T>id='내 용' ,left=1069 ,top=1177 ,right=1291 ,bottom=1238</T>";
        	ls_for += "<T>id='수 여 처' ,left=699 ,top=1177 ,right=921 ,bottom=1238</T>";
        	ls_for += "<L> left=355 ,top=1167 ,right=355 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=664 ,top=1167 ,right=664 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";         	
        	ls_for += "<L> left=976 ,top=1169 ,right=976 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";    
        	ls_for += "<L> left=1421 ,top=1169 ,right=1421 ,bottom=1876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<C>id='REPU_YMD1', left=124, top=1265, right=347, bottom=1328</C>";
        	ls_for += "<C>id='REPU_YMD2', left=124, top=1352, right=347, bottom=1416</C>";
        	ls_for += "<C>id='REPU_YMD3', left=124, top=1439, right=347, bottom=1503</C>";
        	ls_for += "<C>id='REPU_YMD4', left=124, top=1527, right=347, bottom=1590</C>";
        	ls_for += "<C>id='REPU_YMD5', left=124, top=1619, right=347, bottom=1683</C>";
        	ls_for += "<C>id='REPU_YMD6', left=124, top=1712, right=347, bottom=1775</C>";
        	ls_for += "<C>id='REPU_YMD7', left=124, top=1799, right=347, bottom=1863</C>";

        	ls_for += "<C>id='REPU_TNM1', left=360, top=1265, right=659, bottom=1328</C>";
        	ls_for += "<C>id='REPU_TNM2', left=360, top=1355, right=659, bottom=1418</C>";
        	ls_for += "<C>id='REPU_TNM3', left=360, top=1442, right=659, bottom=1505</C>";
        	ls_for += "<C>id='REPU_TNM4', left=360, top=1527, right=659, bottom=1590</C>";
        	ls_for += "<C>id='REPU_TNM5', left=360, top=1619, right=659, bottom=1683</C>";
        	ls_for += "<C>id='REPU_TNM6', left=360, top=1712, right=659, bottom=1775</C>";
        	ls_for += "<C>id='REPU_TNM7', left=360, top=1799, right=659, bottom=1863</C>";

        	ls_for += "<C>id='SYC_NAM1', left=669, top=1265, right=968, bottom=1328</C>";
        	ls_for += "<C>id='SYC_NAM2', left=669, top=1355, right=968, bottom=1418</C>";
        	ls_for += "<C>id='SYC_NAM3', left=669, top=1442, right=968, bottom=1505</C>";
        	ls_for += "<C>id='SYC_NAM4', left=669, top=1527, right=968, bottom=1590</C>";
        	ls_for += "<C>id='SYC_NAM5', left=669, top=1619, right=968, bottom=1683</C>";
        	ls_for += "<C>id='SYC_NAM6', left=669, top=1712, right=968, bottom=1775</C>";
        	ls_for += "<C>id='SYC_NAM7', left=669, top=1799, right=968, bottom=1863</C>";

        	ls_for += "<C>id='REPU_RMK1', left=982, top=1262, right=1418, bottom=1326</C>";
        	ls_for += "<C>id='REPU_RMK2', left=982, top=1352, right=1418, bottom=1416</C>";
        	ls_for += "<C>id='REPU_RMK3', left=982, top=1442, right=1418, bottom=1505</C>";
        	ls_for += "<C>id='REPU_RMK4', left=982, top=1529, right=1418, bottom=1593</C>";
        	ls_for += "<C>id='REPU_RMK5', left=982, top=1619, right=1418, bottom=1683</C>";
        	ls_for += "<C>id='REPU_RMK6', left=982, top=1715, right=1418, bottom=1778</C>";
        	ls_for += "<C>id='REPU_RMK7', left=982, top=1802, right=1418, bottom=1865</C>";        	

        	ls_for += "<C>id='EDU_YMD1', left=1445, top=296, right=1828, bottom=360</C>";
        	ls_for += "<C>id='EDU_YMD2', left=1445, top=370, right=1828, bottom=434</C>";
        	ls_for += "<C>id='EDU_YMD3', left=1445, top=442, right=1828, bottom=505</C>";
        	ls_for += "<C>id='EDU_YMD4', left=1445, top=521, right=1828, bottom=585</C>";
        	ls_for += "<C>id='EDU_YMD5', left=1445, top=601, right=1828, bottom=664</C>";
        	ls_for += "<C>id='EDU_YMD6', left=1445, top=677, right=1828, bottom=741</C>";
        	ls_for += "<C>id='EDU_YMD7', left=1445, top=762, right=1828, bottom=826</C>";
        	ls_for += "<C>id='EDU_YMD8', left=1445, top=844, right=1828, bottom=908</C>";
        	ls_for += "<C>id='EDU_YMD9', left=1445, top=923, right=1828, bottom=987</C>";
        	ls_for += "<C>id='EDU_YMD10', left=1445, top=1008, right=1828, bottom=1072</C>";
        	ls_for += "<C>id='EDU_YMD11', left=1445, top=1093, right=1828, bottom=1156</C>";
        	ls_for += "<C>id='EDU_YMD12', left=1445, top=1177, right=1828, bottom=1241</C>";
        	ls_for += "<C>id='EDU_YMD13', left=1445, top=1265, right=1828, bottom=1328</C>";
        	ls_for += "<C>id='EDU_YMD14', left=1445, top=1355, right=1828, bottom=1418</C>";
        	ls_for += "<C>id='EDU_YMD15', left=1445, top=1439, right=1828, bottom=1503</C>";
        	ls_for += "<C>id='EDU_YMD16', left=1445, top=1529, right=1828, bottom=1593</C>";
        	ls_for += "<C>id='EDU_YMD17', left=1445, top=1619, right=1828, bottom=1683</C>";
        	ls_for += "<C>id='EDU_YMD18', left=1445, top=1715, right=1828, bottom=1778</C>";
        	ls_for += "<C>id='EDU_YMD19', left=1445, top=1802, right=1828, bottom=1865</C>";

        	ls_for += "<C>id='EDU_NM1', left=1839, top=296, right=2434, bottom=360</C>";
        	ls_for += "<C>id='EDU_NM2', left=1839, top=368, right=2434, bottom=431</C>";
        	ls_for += "<C>id='EDU_NM3', left=1839, top=442, right=2434, bottom=505</C>";
        	ls_for += "<C>id='EDU_NM4', left=1839, top=521, right=2434, bottom=585</C>";
        	ls_for += "<C>id='EDU_NM5', left=1839, top=601, right=2434, bottom=664</C>";
        	ls_for += "<C>id='EDU_NM6', left=1839, top=677, right=2434, bottom=741</C>";
        	ls_for += "<C>id='EDU_NM7', left=1839, top=762, right=2434, bottom=826</C>";
        	ls_for += "<C>id='EDU_NM8', left=1839, top=844, right=2434, bottom=908</C>";
        	ls_for += "<C>id='EDU_NM9', left=1839, top=923, right=2434, bottom=987</C>";
        	ls_for += "<C>id='EDU_NM10', left=1839, top=1008, right=2434, bottom=1072</C>";
        	ls_for += "<C>id='EDU_NM11', left=1839, top=1093, right=2434, bottom=1156</C>";
        	ls_for += "<C>id='EDU_NM12', left=1839, top=1177, right=2434, bottom=1241</C>";
        	ls_for += "<C>id='EDU_NM13', left=1839, top=1265, right=2434, bottom=1328</C>";
        	ls_for += "<C>id='EDU_NM14', left=1839, top=1355, right=2434, bottom=1418</C>";
        	ls_for += "<C>id='EDU_NM15', left=1839, top=1439, right=2434, bottom=1503</C>";
        	ls_for += "<C>id='EDU_NM16', left=1839, top=1529, right=2434, bottom=1593</C>";
        	ls_for += "<C>id='EDU_NM17', left=1839, top=1619, right=2434, bottom=1683</C>";
        	ls_for += "<C>id='EDU_NM18', left=1839, top=1715, right=2434, bottom=1778</C>";
        	ls_for += "<C>id='EDU_NM19', left=1839, top=1802, right=2434, bottom=1865</C>";

        	ls_for += "<C>id='INT_NAM1', left=2445, top=296, right=2834, bottom=360</C>";
        	ls_for += "<C>id='INT_NAM2', left=2445, top=368, right=2834, bottom=431</C>";
        	ls_for += "<C>id='INT_NAM3', left=2445, top=442, right=2834, bottom=505</C>";
        	ls_for += "<C>id='INT_NAM4', left=2445, top=521, right=2834, bottom=585</C>";
        	ls_for += "<C>id='INT_NAM5', left=2445, top=601, right=2834, bottom=664</C>";
        	ls_for += "<C>id='INT_NAM6', left=2445, top=677, right=2834, bottom=741</C>";
        	ls_for += "<C>id='INT_NAM7', left=2445, top=762, right=2834, bottom=826</C>";
        	ls_for += "<C>id='INT_NAM8', left=2445, top=844, right=2834, bottom=908</C>";
        	ls_for += "<C>id='INT_NAM9', left=2445, top=923, right=2834, bottom=987</C>";
        	ls_for += "<C>id='INT_NAM10', left=2445, top=1008, right=2834, bottom=1072</C>";
        	ls_for += "<C>id='INT_NAM11', left=2445, top=1093, right=2834, bottom=1156</C>";
        	ls_for += "<C>id='INT_NAM12', left=2445, top=1177, right=2834, bottom=1241</C>";
        	ls_for += "<C>id='INT_NAM13', left=2445, top=1265, right=2834, bottom=1328</C>";
        	ls_for += "<C>id='INT_NAM14', left=2445, top=1355, right=2834, bottom=1418</C>";
        	ls_for += "<C>id='INT_NAM15', left=2445, top=1439, right=2834, bottom=1503</C>";
        	ls_for += "<C>id='INT_NAM16', left=2445, top=1529, right=2834, bottom=1593</C>";
        	ls_for += "<C>id='INT_NAM17', left=2445, top=1619, right=2834, bottom=1683</C>";
        	ls_for += "<C>id='INT_NAM18', left=2445, top=1715, right=2834, bottom=1778</C>";
        	ls_for += "<C>id='INT_NAM19', left=2445, top=1802, right=2834, bottom=1865</C>";       	

        	ls_for += "<I>id='../../../Common/img/icon.jpg' ,left=2471 ,top=1880 ,right=2823 ,bottom=1960</I>";        	
        	
        	ls_for += "</B>";        	
        	ls_for += "</R>";
            ls_for += "</A>";              
            
            
        	//3번째
        	ls_for += "<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=132";
            ls_for += "<R>id='3쪽.sbt' ,left=0 ,top=0 ,right=2871 ,bottom=132, MasterDataID='dsT_RP_REPORT00'";        	

        	ls_for += "<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=1897 ,face='Tahoma' ,size=10 ,penwidth=1";
        	ls_for += "<T>id='인 사 기 록 표 (3)' ,left=622 ,top=21 ,right=2199 ,bottom=114 ,face='Tahoma' ,size=26 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
        	ls_for += "<T>id='출력일 :' ,left=2357 ,top=77 ,right=2516 ,bottom=124</T>";
        	ls_for += "<T>id='"+gs_cdate+"' ,left=2532 ,top=71 ,right=2820 ,bottom=132 ,align='left' ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>";
        	ls_for += "<T>id='입 사 후 경 력 사 항' ,left=48 ,top=151 ,right=1386 ,bottom=212</T>";
        	ls_for += "<T>id='비고' ,left=1185 ,top=225 ,right=1413 ,bottom=267</T>";
        	ls_for += "<T>id='발령구분' ,left=220 ,top=225 ,right=378 ,bottom=267</T>";
        	ls_for += "<T>id='파트' ,left=902 ,top=225 ,right=1119 ,bottom=267</T>";
        	ls_for += "<T>id='소속' ,left=587 ,top=225 ,right=802 ,bottom=267</T>";
        	ls_for += "<T>id='발령일자' ,left=42 ,top=225 ,right=198 ,bottom=267</T>";
        	ls_for += "<T>id='직위' ,left=400 ,top=225 ,right=527 ,bottom=267</T>";

        	ls_for += "<L> left=21 ,top=217 ,right=1423 ,bottom=217 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=148 ,right=1423 ,bottom=148 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=148 ,right=21 ,bottom=1820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=273 ,right=1423 ,bottom=273 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=323 ,right=1423 ,bottom=323 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=376 ,right=1423 ,bottom=376 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=431 ,right=1423 ,bottom=431 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=487 ,right=1423 ,bottom=487 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=542 ,right=1423 ,bottom=542 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1423 ,top=148 ,right=1423 ,bottom=1820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1423 ,top=598 ,right=21 ,bottom=598 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=654 ,right=1423 ,bottom=654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=765 ,right=1423 ,bottom=765 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=820 ,right=1423 ,bottom=820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=876 ,right=1423 ,bottom=876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=709 ,right=1423 ,bottom=709 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=931 ,right=1423 ,bottom=931 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=987 ,right=1423 ,bottom=987 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1042 ,right=1423 ,bottom=1042 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1098 ,right=1423 ,bottom=1098 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1154 ,right=1423 ,bottom=1154 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1209 ,right=1423 ,bottom=1209 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1265 ,right=1423 ,bottom=1265 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1320 ,right=1423 ,bottom=1320 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1376 ,right=1423 ,bottom=1376 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1431 ,right=1423 ,bottom=1431 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1487 ,right=1423 ,bottom=1487 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1543 ,right=1423 ,bottom=1543 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1654 ,right=1423 ,bottom=1654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1598 ,right=1423 ,bottom=1598 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1709 ,right=1423 ,bottom=1709 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1765 ,right=1423 ,bottom=1765 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=21 ,top=1820 ,right=1423 ,bottom=1820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1180 ,top=220 ,right=1180 ,bottom=1820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=206 ,top=217 ,right=206 ,bottom=1818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=397 ,top=220 ,right=397 ,bottom=1820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=550 ,top=217 ,right=550 ,bottom=1818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=841 ,top=217 ,right=841 ,bottom=1818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";

        	ls_for += "<C>id='STR_YMD1', left=26, top=275, right=201, bottom=320, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD2', left=26, top=325, right=201, bottom=373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD3', left=26, top=378, right=201, bottom=429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD4', left=26, top=434, right=201, bottom=484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD5', left=26, top=489, right=201, bottom=540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD6', left=26, top=545, right=201, bottom=595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD7', left=26, top=601, right=201, bottom=651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD8', left=26, top=656, right=201, bottom=706, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD9', left=26, top=712, right=201, bottom=762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD10', left=26, top=767, right=201, bottom=818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD11' left=26, top=823, right=201, bottom=873, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD12', left=26, top=878, right=201, bottom=929, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD13', left=26, top=934, right=201, bottom=984, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD14', left=26, top=990, right=201, bottom=1040, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD15', left=26, top=1045, right=201, bottom=1095, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD16', left=26, top=1101, right=201, bottom=1151, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD17', left=26, top=1156, right=201, bottom=1207, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD18', left=26, top=1212, right=201, bottom=1262, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD19', left=26, top=1267, right=201, bottom=1318, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD20', left=26, top=1323, right=201, bottom=1373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD21', left=26, top=1378, right=201, bottom=1429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD22', left=26, top=1434, right=201, bottom=1484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD23', left=26, top=1490, right=201, bottom=1540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD24', left=26, top=1545, right=201, bottom=1595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD25', left=26, top=1601, right=201, bottom=1651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD26', left=26, top=1656, right=201, bottom=1707, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD27', left=26, top=1712, right=201, bottom=1762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD28', left=26, top=1767, right=201, bottom=1818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";        	
        	
        	ls_for += "<C>id='APP_NM1', left=209, top=275, right=392, bottom=320, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM2', left=209, top=325, right=392, bottom=373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM3', left=209, top=378, right=392, bottom=429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM4', left=209, top=434, right=392, bottom=484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM5', left=209, top=489, right=392, bottom=540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM6', left=209, top=545, right=392, bottom=595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM7', left=209, top=601, right=392, bottom=651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM8', left=209, top=656, right=392, bottom=706, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM9', left=209, top=712, right=392, bottom=762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM10', left=209, top=767, right=392, bottom=818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM11', left=209, top=823, right=392, bottom=873, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM12', left=209, top=878, right=392, bottom=929, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM13', left=209, top=934, right=392, bottom=984, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM14', left=209, top=990, right=392, bottom=1040, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM15', left=209, top=1045, right=392, bottom=1095, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM16', left=209, top=1101, right=392, bottom=1151, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM17', left=209, top=1156, right=392, bottom=1207, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM18', left=209, top=1212, right=392, bottom=1262, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM19', left=209, top=1267, right=392, bottom=1318, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM20', left=209, top=1323, right=392, bottom=1373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM21', left=209, top=1378, right=392, bottom=1429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM22', left=209, top=1434, right=392, bottom=1484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM23', left=209, top=1490, right=392, bottom=1540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM24', left=209, top=1545, right=392, bottom=1595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM25', left=209, top=1601, right=392, bottom=1651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM26', left=209, top=1656, right=392, bottom=1707, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM27', left=209, top=1712, right=392, bottom=1762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM28', left=209, top=1767, right=392, bottom=1818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";        	
        	
        	ls_for += "<C>id='JOB_NM1', left=400, top=275, right=548, bottom=320, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM2', left=400, top=325, right=548, bottom=373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM3', left=400, top=378, right=548, bottom=429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM4', left=400, top=434, right=548, bottom=484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM5', left=400, top=489, right=548, bottom=540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM6', left=400, top=545, right=548, bottom=595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM7', left=400, top=601, right=548, bottom=651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM8',   left=400, top=656, right=548, bottom=706, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM9',   left=400, top=712, right=548, bottom=762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM10', left=400, top=767, right=548, bottom=818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM11', left=400, top=823, right=548, bottom=873, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM12', left=400, top=878, right=548, bottom=929, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM13', left=400, top=934, right=548, bottom=984, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM14', left=400, top=990, right=548, bottom=1040, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM15', left=400, top=1045, right=548, bottom=1095, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM16', left=400, top=1101, right=548, bottom=1151, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM17', left=400, top=1156, right=548, bottom=1207, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM18', left=400, top=1212, right=548, bottom=1262, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM19', left=400, top=1267, right=548, bottom=1318, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM20', left=400, top=1323, right=548, bottom=1373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM21', left=400, top=1378, right=548, bottom=1429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM22', left=400, top=1434, right=548, bottom=1484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM23', left=400, top=1490, right=548, bottom=1540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM24', left=400, top=1545, right=548, bottom=1595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM25', left=400, top=1601, right=548, bottom=1651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM26', left=400, top=1656, right=548, bottom=1707, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM27', left=400, top=1712, right=548, bottom=1762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM28', left=400, top=1767, right=548, bottom=1818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";

        	ls_for += "<C>id='DPT_NM1', left=553, top=275, right=839, bottom=320, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM2', left=553, top=325, right=839, bottom=373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM3', left=553, top=378, right=839, bottom=429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM4', left=553, top=434, right=839, bottom=484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM5', left=553, top=489, right=839, bottom=540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM6', left=553, top=545, right=839, bottom=595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM7', left=553, top=601, right=839, bottom=651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM8',   left=553, top=656, right=839, bottom=706, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM9',   left=553, top=712, right=839, bottom=762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM10', left=553, top=767, right=839, bottom=818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM11', left=553, top=823, right=839, bottom=873, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM12', left=553, top=878, right=839, bottom=929, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM13', left=553, top=934, right=839, bottom=984, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM14', left=553, top=990, right=839, bottom=1040, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM15', left=553, top=1045, right=839, bottom=1095, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM16', left=553, top=1101, right=839, bottom=1151, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM17', left=553, top=1156, right=839, bottom=1207, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM18', left=553, top=1212, right=839, bottom=1262, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM19', left=553, top=1267, right=839, bottom=1318, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM20', left=553, top=1323, right=839, bottom=1373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM21', left=553, top=1378, right=839, bottom=1429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM22', left=553, top=1434, right=839, bottom=1484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM23', left=553, top=1490, right=839, bottom=1540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM24', left=553, top=1545, right=839, bottom=1595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM25', left=553, top=1601, right=839, bottom=1651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM26', left=553, top=1656, right=839, bottom=1707, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM27', left=553, top=1712, right=839, bottom=1762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM28', left=553, top=1767, right=839, bottom=1818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";

        	ls_for += "<C>id='TEAM_NM1', left=844, top=275, right=1177, bottom=320, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM2', left=844, top=325, right=1177, bottom=373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM3', left=844, top=378, right=1177, bottom=429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM4', left=844, top=434, right=1177, bottom=484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM5', left=844, top=489, right=1177, bottom=540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM6', left=844, top=545, right=1177, bottom=595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM7', left=844, top=601, right=1177, bottom=651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM8', left=844, top=656, right=1177, bottom=706, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";        	
        	ls_for += "<C>id='TEAM_NM9',  left=844, top=712, right=1177, bottom=762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM10', left=844, top=767, right=1177, bottom=818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM11', left=844, top=823, right=1177, bottom=873, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM12', left=844, top=878, right=1177, bottom=929, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM13', left=844, top=934, right=1177, bottom=984, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM14', left=844, top=990, right=1177, bottom=1040, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM15', left=844, top=1045, right=1177, bottom=1095, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM16', left=844, top=1101, right=1177, bottom=1151, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM17', left=844, top=1156, right=1177, bottom=1207, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM18', left=844, top=1212, right=1177, bottom=1262, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM19', left=844, top=1267, right=1177, bottom=1318, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM20', left=844, top=1323, right=1177, bottom=1373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM21', left=844, top=1378, right=1177, bottom=1429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM22', left=844, top=1434, right=1177, bottom=1484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM23', left=844, top=1490, right=1177, bottom=1540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM24', left=844, top=1545, right=1177, bottom=1595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM25', left=844, top=1601, right=1177, bottom=1651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM26', left=844, top=1656, right=1177, bottom=1707, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM27', left=844, top=1712, right=1177, bottom=1762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM28', left=844, top=1767, right=1177, bottom=1818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";

        	ls_for += "<C>id='REMARK1', left=1181, top=275, right=1427, bottom=320, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK2', left=1181, top=325, right=1427, bottom=373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK3', left=1181, top=378, right=1427, bottom=429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK4', left=1181, top=434, right=1427, bottom=484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK5', left=1181, top=489, right=1427, bottom=540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK6', left=1181, top=545, right=1427, bottom=595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK7', left=1181, top=601, right=1427, bottom=651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK8', left=1181, top=656, right=1427, bottom=706, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK9', left=1181, top=712, right=1427, bottom=762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK10', left=1181, top=767, right=1427, bottom=818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK11', left=1181, top=823, right=1427, bottom=873, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK12', left=1181, top=878, right=1427, bottom=929, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK13', left=1181, top=934, right=1427, bottom=984, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK14', left=1181, top=990, right=1427, bottom=1040, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK15', left=1181, top=1045, right=1427, bottom=1095, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK16', left=1181, top=1101, right=1427, bottom=1151, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK17', left=1181, top=1156, right=1427, bottom=1207, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK18', left=1181, top=1212, right=1427, bottom=1262, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK19', left=1181, top=1267, right=1427, bottom=1318, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK20', left=1181, top=1323, right=1427, bottom=1373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK21', left=1181, top=1378, right=1427, bottom=1429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK22', left=1181, top=1434, right=1427, bottom=1484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK23', left=1181, top=1490, right=1427, bottom=1540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK24', left=1181, top=1545, right=1427, bottom=1595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK25', left=1181, top=1601, right=1427, bottom=1651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK26', left=1181, top=1656, right=1427, bottom=1707, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK27', left=1181, top=1712, right=1427, bottom=1762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK28', left=1181, top=1767, right=1427, bottom=1818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";

        	ls_for += "<T>id='입 사 후 경 력 사 항' ,left=1461 ,top=151 ,right=2799 ,bottom=212</T>";
        	ls_for += "<T>id='비고' ,left=2598 ,top=225 ,right=2826 ,bottom=267</T>";
        	ls_for += "<T>id='발령구분' ,left=1632 ,top=225 ,right=1791 ,bottom=267</T>";
        	ls_for += "<T>id='파트' ,left=2315 ,top=225 ,right=2532 ,bottom=267</T>";
        	ls_for += "<T>id='소속' ,left=2000 ,top=225 ,right=2215 ,bottom=267</T>";
        	ls_for += "<T>id='발령일자' ,left=1455 ,top=225 ,right=1611 ,bottom=267</T>";
        	ls_for += "<T>id='직위' ,left=1812 ,top=225 ,right=1939 ,bottom=267</T>";
        	ls_for += "<L> left=1434 ,top=217 ,right=2836 ,bottom=217 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=148 ,right=2836 ,bottom=148 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=148 ,right=1434 ,bottom=1820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=273 ,right=2836 ,bottom=273 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=323 ,right=2836 ,bottom=323 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=376 ,right=2836 ,bottom=376 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=431 ,right=2836 ,bottom=431 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=487 ,right=2836 ,bottom=487 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=542 ,right=2836 ,bottom=542 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2836 ,top=148 ,right=2836 ,bottom=1820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2836 ,top=598 ,right=1434 ,bottom=598 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=654 ,right=2836 ,bottom=654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=765 ,right=2836 ,bottom=765 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=820 ,right=2836 ,bottom=820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=876 ,right=2836 ,bottom=876 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=709 ,right=2836 ,bottom=709 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=931 ,right=2836 ,bottom=931 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=987 ,right=2836 ,bottom=987 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1042 ,right=2836 ,bottom=1042 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1098 ,right=2836 ,bottom=1098 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1154 ,right=2836 ,bottom=1154 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1209 ,right=2836 ,bottom=1209 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1265 ,right=2836 ,bottom=1265 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1320 ,right=2836 ,bottom=1320 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1376 ,right=2836 ,bottom=1376 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1431 ,right=2836 ,bottom=1431 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1487 ,right=2836 ,bottom=1487 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1543 ,right=2836 ,bottom=1543 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1654 ,right=2836 ,bottom=1654 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1598 ,right=2836 ,bottom=1598 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1709 ,right=2836 ,bottom=1709 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1765 ,right=2836 ,bottom=1765 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1434 ,top=1820 ,right=2836 ,bottom=1820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2593 ,top=220 ,right=2593 ,bottom=1820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1619 ,top=217 ,right=1619 ,bottom=1818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1810 ,top=220 ,right=1810 ,bottom=1820 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=1963 ,top=217 ,right=1963 ,bottom=1818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<L> left=2254 ,top=217 ,right=2254 ,bottom=1818 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>";
        	ls_for += "<C>id='STR_YMD29', left=1439, top=275, right=1614, bottom=320, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD30', left=1439, top=325, right=1614, bottom=373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD31', left=1439, top=378, right=1614, bottom=429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD32', left=1439, top=434, right=1614, bottom=484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD33', left=1439, top=489, right=1614, bottom=540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD34', left=1439, top=545, right=1614, bottom=595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD35', left=1439, top=601, right=1614, bottom=651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD36', left=1439, top=656, right=1614, bottom=706, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD37', left=1439, top=712, right=1614, bottom=762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD38', left=1439, top=767, right=1614, bottom=818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD39', left=1439, top=823, right=1614, bottom=873, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD40', left=1439, top=878, right=1614, bottom=929, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD41', left=1439, top=934, right=1614, bottom=984, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD42', left=1439, top=1045, right=1614, bottom=1095, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD43', left=1439, top=990, right=1614, bottom=1040, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD44', left=1439, top=1101, right=1614, bottom=1151, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD45', left=1439, top=1156, right=1614, bottom=1207, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD46', left=1439, top=1212, right=1614, bottom=1262, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD47', left=1439, top=1267, right=1614, bottom=1318, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD48', left=1439, top=1323, right=1614, bottom=1373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD49', left=1439, top=1378, right=1614, bottom=1429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD50', left=1439, top=1434, right=1614, bottom=1484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD51', left=1439, top=1490, right=1614, bottom=1540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD52', left=1439, top=1545, right=1614, bottom=1595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD53', left=1439, top=1601, right=1614, bottom=1651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD54', left=1439, top=1656, right=1614, bottom=1707, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD55', left=1439, top=1712, right=1614, bottom=1762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='STR_YMD56', left=1439, top=1767, right=1614, bottom=1818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM29', left=1622, top=275, right=1804, bottom=320, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM30', left=1622, top=325, right=1804, bottom=373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM31', left=1622, top=378, right=1804, bottom=429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM32', left=1622, top=434, right=1804, bottom=484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM33', left=1622, top=489, right=1804, bottom=540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM34', left=1622, top=545, right=1804, bottom=595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM35', left=1622, top=601, right=1804, bottom=651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM36', left=1622, top=656, right=1804, bottom=706, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM37', left=1622, top=712, right=1804, bottom=762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM38', left=1622, top=767, right=1804, bottom=818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM39', left=1622, top=823, right=1804, bottom=873, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM40', left=1622, top=878, right=1804, bottom=929, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM41', left=1622, top=934, right=1804, bottom=984, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM42', left=1622, top=990, right=1804, bottom=1040, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM43', left=1622, top=1045, right=1804, bottom=1095, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM44', left=1622, top=1101, right=1804, bottom=1151, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM45', left=1622, top=1156, right=1804, bottom=1207, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM46', left=1622, top=1212, right=1804, bottom=1262, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM47', left=1622, top=1267, right=1804, bottom=1318, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM48', left=1622, top=1323, right=1804, bottom=1373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM49', left=1622, top=1378, right=1804, bottom=1429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM50', left=1622, top=1434, right=1804, bottom=1484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM51', left=1622, top=1490, right=1804, bottom=1540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM52', left=1622, top=1545, right=1804, bottom=1595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM53', left=1622, top=1601, right=1804, bottom=1651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM54', left=1622, top=1656, right=1804, bottom=1707, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM55', left=1622, top=1712, right=1804, bottom=1762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='APP_NM56', left=1622, top=1767, right=1804, bottom=1818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM29', left=1812, top=275, right=1961, bottom=320, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM30', left=1812, top=325, right=1961, bottom=373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM31', left=1812, top=378, right=1961, bottom=429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM32', left=1812, top=434, right=1961, bottom=484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM33', left=1812, top=489, right=1961, bottom=540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM34', left=1812, top=545, right=1961, bottom=595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM35', left=1812, top=601, right=1961, bottom=651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM36', left=1812, top=656, right=1961, bottom=706, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM37', left=1812, top=712, right=1961, bottom=762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM38', left=1812, top=767, right=1961, bottom=818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM39', left=1812, top=823, right=1961, bottom=873, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM40', left=1812, top=878, right=1961, bottom=929, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM41', left=1812, top=934, right=1961, bottom=984, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM42', left=1812, top=990, right=1961, bottom=1040, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM43', left=1812, top=1045, right=1961, bottom=1095, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM44', left=1812, top=1101, right=1961, bottom=1151, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM45', left=1812, top=1156, right=1961, bottom=1207, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM46', left=1812, top=1212, right=1961, bottom=1262, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM47', left=1812, top=1267, right=1961, bottom=1318, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM48', left=1812, top=1323, right=1961, bottom=1373, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM49', left=1812, top=1378, right=1961, bottom=1429, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM50', left=1812, top=1434, right=1961, bottom=1484, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM51', left=1812, top=1490, right=1961, bottom=1540, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM52', left=1812, top=1545, right=1961, bottom=1595, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM53', left=1812, top=1601, right=1961, bottom=1651, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM54', left=1812, top=1656, right=1961, bottom=1707, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM55', left=1812, top=1712, right=1961, bottom=1762, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='JOB_NM56', left=1812, top=1767, right=1961, bottom=1818, face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>";
        	ls_for += "<C>id='DPT_NM29', left=1966, top=275, right=2252, bottom=320, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM30', left=1966, top=325, right=2252, bottom=373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM31', left=1966, top=378, right=2252, bottom=429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM32', left=1966, top=434, right=2252, bottom=484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM33', left=1966, top=489, right=2252, bottom=540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM34', left=1966, top=545, right=2252, bottom=595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM35', left=1966, top=601, right=2252, bottom=651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM36', left=1966, top=656, right=2252, bottom=706, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM37', left=1966, top=712, right=2252, bottom=762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM38', left=1966, top=767, right=2252, bottom=818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM39', left=1966, top=823, right=2252, bottom=873, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM40', left=1966, top=878, right=2252, bottom=929, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM41', left=1966, top=934, right=2252, bottom=984, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM42', left=1966, top=990, right=2252, bottom=1040, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM43', left=1966, top=1045, right=2252, bottom=1095, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM44', left=1966, top=1101, right=2252, bottom=1151, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM45', left=1966, top=1156, right=2252, bottom=1207, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM46', left=1966, top=1212, right=2252, bottom=1262, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM47', left=1966, top=1267, right=2252, bottom=1318, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM48', left=1966, top=1323, right=2252, bottom=1373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM49', left=1966, top=1378, right=2252, bottom=1429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM50', left=1966, top=1434, right=2252, bottom=1484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM51', left=1966, top=1490, right=2252, bottom=1540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM52', left=1966, top=1545, right=2252, bottom=1595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM53', left=1966, top=1601, right=2252, bottom=1651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM54', left=1966, top=1656, right=2252, bottom=1707, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM55', left=1966, top=1712, right=2252, bottom=1762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='DPT_NM56', left=1966, top=1767, right=2252, bottom=1818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM29', left=2257, top=275, right=2590, bottom=320, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM30', left=2257, top=325, right=2590, bottom=373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM31', left=2257, top=378, right=2590, bottom=429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM32', left=2257, top=434, right=2590, bottom=484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM33', left=2257, top=489, right=2590, bottom=540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM34', left=2257, top=545, right=2590, bottom=595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM35', left=2257, top=601, right=2590, bottom=651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM36', left=2257, top=656, right=2590, bottom=706, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM37', left=2257, top=712, right=2590, bottom=762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM38', left=2257, top=767, right=2590, bottom=818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM39', left=2257, top=823, right=2590, bottom=873, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM40', left=2257, top=878, right=2590, bottom=929, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM41', left=2257, top=934, right=2590, bottom=984, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM42', left=2257, top=990, right=2590, bottom=1040, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM43', left=2257, top=1045, right=2590, bottom=1095, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM44', left=2257, top=1101, right=2590, bottom=1151, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM45', left=2257, top=1156, right=2590, bottom=1207, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM46', left=2257, top=1212, right=2590, bottom=1262, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM47', left=2257, top=1267, right=2590, bottom=1318, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM48', left=2257, top=1323, right=2590, bottom=1373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM49', left=2257, top=1378, right=2590, bottom=1429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM50', left=2257, top=1434, right=2590, bottom=1484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM51', left=2257, top=1490, right=2590, bottom=1540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM52', left=2257, top=1545, right=2590, bottom=1595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM53', left=2257, top=1601, right=2590, bottom=1651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM54', left=2257, top=1656, right=2590, bottom=1707, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM55', left=2257, top=1712, right=2590, bottom=1762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='TEAM_NM56', left=2257, top=1767, right=2590, bottom=1818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK29', left=2593, top=275, right=2839, bottom=320, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK30', left=2593, top=325, right=2839, bottom=373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK31', left=2593, top=378, right=2839, bottom=429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK32', left=2593, top=434, right=2839, bottom=484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK33', left=2593, top=489, right=2839, bottom=540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK34', left=2593, top=545, right=2839, bottom=595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK35', left=2593, top=601, right=2839, bottom=651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK36', left=2593, top=656, right=2839, bottom=706, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK37', left=2593, top=712, right=2839, bottom=762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK38', left=2593, top=767, right=2839, bottom=818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK39', left=2593, top=823, right=2839, bottom=873, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK40', left=2593, top=878, right=2839, bottom=929, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK41', left=2593, top=934, right=2839, bottom=984, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK42', left=2593, top=990, right=2839, bottom=1040, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK43', left=2593, top=1045, right=2839, bottom=1095, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK44', left=2593, top=1101, right=2839, bottom=1151, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK45', left=2593, top=1156, right=2839, bottom=1207, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK46', left=2593, top=1212, right=2839, bottom=1262, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK47', left=2593, top=1267, right=2839, bottom=1318, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK48', left=2593, top=1323, right=2839, bottom=1373, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK49', left=2593, top=1378, right=2839, bottom=1429, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK50', left=2593, top=1434, right=2839, bottom=1484, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK51', left=2593, top=1490, right=2839, bottom=1540, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK52', left=2593, top=1545, right=2839, bottom=1595, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK53', left=2593, top=1601, right=2839, bottom=1651, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK54', left=2593, top=1656, right=2839, bottom=1707, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK55', left=2593, top=1712, right=2839, bottom=1762, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";
        	ls_for += "<C>id='REMARK56', left=2593, top=1767, right=2839, bottom=1818, align='left', face='Tahoma', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Multiline=true</C>";

        	ls_for += "<I>id='../../../Common/img/icon.jpg' ,left=2471 ,top=1880 ,right=2823 ,bottom=1960</I>";   
        	ls_for += "</B>";
        	ls_for += "</R>";
            ls_for += "</A>"; 
            
            
          
     
			
			ReportID.format = '';

        	ReportID.format = ReportID.format + ls_for;

        	ReportID.Preview();

        }

        
       
        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsT_CM_PERSON.CountColumn == 0) {
                dsT_CM_PERSON.setDataHeader("ENO_NO:STRING:NOTNULL, OCC_CD:STRING, ENO_NM:STRING, NAM_ENG:STRING, NAM_CHI:STRING, MF_TAG:STRING, BIR_YMD:STRING, BIR_TAG:STRING, CET_NO:STRING, HEAD_CD:STRING, RETP_YMD:STRING, DPT_CD:STRING, JOB_CD:STRING, JPR_YMD:STRING, DUTY_CD:STRING, TEAM_CD:STRING, HOB_CD:STRING, HBA_YMD:STRING, HIR_YMD:STRING, HIRG_YMD:STRING, TAX_DPT:STRING");
            }

            if (dsT_CM_PERSON.IsUpdated ) {
                alert("해당 필수입력항목[사번/성명]을 입력하지 않으셨거나 변경사항이 존재합니다.\n해당 작업 종료한 후에 신규 작업을 하시기 바랍니다.");
                document.getElementById("txtENO_NM").focus();
                return;
            }

            fnc_Clear();

            dsT_CM_PERSON.ClearData();

            // AddNew 후 Grid에 새로 생긴 Row의 특정 Column으로 이동하는거
            dsT_CM_PERSON.AddRow();

            fnc_ViewFrame(1);


            
            // KEY 필드는 신규시 입력 가능
            document.getElementById("txtENO_NO").disabled = false;
            document.getElementById("cmbBIR_TAG").value = 'S';

            fnc_ColEnabled('E');

            txtENO_NM.focus();
            //form1.txtENO_NM.focus();
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
        	
            document.getElementById("txtENO_NO").value   = '';
            document.getElementById("txtENO_NM").value   = '';
            document.getElementById("txtNAM_CHI").value  = '';
            document.getElementById("txtBIR_YMD").value  = '';
            document.getElementById("txtAGE").value      = '';
            document.getElementById("cmbBIR_TAG").value  = '';         
            document.getElementById("txtNAM_ENG").value  = '';
            document.getElementById("txtCET_NO").value   = '';
            document.getElementById("cmbMF_TAG").value   = '';
            document.getElementById("txtHIR_YMD").value  = '';
            document.getElementById("txtHEAD_CD").value  = '';
            document.getElementById("txtHEAD_NM").value  = '';          
            document.getElementById("txtOCC_CD").value   = '';
            document.getElementById("txtOCC_NM").value   = '';
            document.getElementById("txtHIRG_YMD").value = '';
            document.getElementById("txtDPT_CD").value   = '';
            document.getElementById("txtDPT_NM").value   = '';
            document.getElementById("txtJOB_CD").value   = '';
            document.getElementById("txtJOB_NM").value   = '';
            document.getElementById("txtJPR_YMD").value  = '';          
            document.getElementById("txtTEAM_CD").value  = '';
            document.getElementById("txtTEAM_NM").value  = '';
            document.getElementById("txtHOB_CD").value   = '';
            document.getElementById("txtHOB_NM").value   = '';
            document.getElementById("txtDUTY_CD").value  = '';
            document.getElementById("txtDUTY_NM").value  = '';
            document.getElementById("txtRETP_YMD").value   = '';
                     

            document.getElementById("resultMessage").innerText = ' ';

            dsT_CM_PERSON.ClearData();

            document.getElementById('view_1').style.display='inline';

            // 서브탭 초기화면 호출
            fnc_ViewFrame(1);
            fnc_ViewFrameTab(1);

            fnc_ColEnabled('D');

            // 이미지 초기화
	        //var f = document.form1;
	        //f.photo.src="../../images/common/none.jpg";            
            //photo.src="../../images/common/none.jpg";

            document.getElementById("txtENO_NO").disabled = false;
            document.getElementById("txtENO_NM").focus();

            old_enono = "";

            document.getElementById("txtENO_NO").disabled = false;
            document.getElementById("txtENO_NM").focus();

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
        	
            //var f = document.form1;

            if (dsT_CM_PERSON.OrgNameString(dsT_CM_PERSON.RowPosition,"ENO_NO") != document.getElementById("txtENO_NO").value) {
                alert("사번은 변경할 수 없습니다!");
                document.getElementById("txtENO_NO").value = dsT_CM_PERSON.OrgNameString(dsT_CM_PERSON.RowPosition,"ENO_NO");
                document.getElementById("txtENO_NM").focus();
                return false;
            }

            //DataSet의 변경 여부 확인
            if (!dsT_CM_PERSON.IsUpdated ) {
                document.getElementById("resultMessage").innerText = "* 저장할 내용이 없습니다.";
                return false;
            }

            // 국문성명
            if (document.getElementById("txtENO_NM").value == "") {
                alert("국문성명은 필수 입력사항입니다.");
                document.getElementById("txtENO_NM").focus();
                return false;
            }

            // 생년월일
            if (document.getElementById("txtBIR_YMD").value == "") {
                alert("생년월일은 필수 입력사항입니다.");
                document.getElementById("txtBIR_YMD").focus();
                return false;
            }

            // 생년월일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtBIR_YMD"), '생년월일')) {
                document.getElementById("txtBIR_YMD").focus();
                return false;
            }

            // 주민번호
            if (document.getElementById("txtCET_NO").value == "") {
                alert("주민번호는 필수 입력사항입니다.");
                document.getElementById("txtCET_NO").focus();
                return false;
            }

            // 주민번호 CHECK
            if (!fnc_SsnValid(document.getElementById("txtCET_NO"))) {
                document.getElementById("txtCET_NO").focus();
                return false;
            }

            // 성별 CHECK
            if ((document.getElementById("txtCET_NO").value.substr(7,1) == "1" &&  document.getElementById("cmbMF_TAG").value != "M") ||
                (document.getElementById("txtCET_NO").value.substr(7,1) == "2" &&  document.getElementById("cmbMF_TAG").value != "F")) {
                alert("잘못된 성별입니다. 확인하시기 바랍니다.");
                document.getElementById("cmbMF_TAG").focus();
                return false;
            }

            // 입사일
            if (document.getElementById("txtHIR_YMD").value == "") {
                alert("입사일은 필수 입력사항입니다.");
                document.getElementById("txtHIR_YMD").focus();
                return false;
            }

            // 입사일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtHIR_YMD"), '입사일') && document.getElementById("txtHIR_YMD").value != "") {
                document.getElementById("txtHIR_YMD").focus();
                return false;
            }

            // 그룹입사일
            if (document.getElementById("txtHIRG_YMD").value == "") {
                alert("그룹입사일은 필수 입력사항입니다.");
                document.getElementById("txtHIRG_YMD").focus();
                return false;
            }

            // 그룹입사일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtHIRG_YMD"), '그룹입사일') && document.getElementById("txtHIRG_YMD").value != "") {
                document.getElementById("txtHIRG_YMD").focus();
                return false;
            }

            // 승진일
            if (document.getElementById("txtJPR_YMD").value == "") {
                alert("승진일은 필수 입력사항입니다.");
                document.getElementById("txtJPR_YMD").focus();
                return false;
            }

            // 승진일 CHECK
            if (!fnc_CheckDate(document.getElementById("txtJPR_YMD"), '승진일') && document.getElementById("txtJPR_YMD").value != "") {
                document.getElementById("txtJPR_YMD").focus();
                return false;
            }

            // 계약만료일 CHECK 계약직은 계약만료일 필수 2020.10.23
            //alert(document.getElementById("txtENO_NO").value.substr(0,1));
            if (document.getElementById("txtENO_NO").value.substr(0,1) == "3" || document.getElementById("txtENO_NO").value.substr(0,1) == "4" ) {            

	            if (document.getElementById("txtRETP_YMD").value == "") {
	            	alert("계약직은 계약만료일이 필수 입력사항입니다.");
	                document.getElementById("txtRETP_YMD").focus();
	                return false;
	            }
            
            }

            return true;
        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

        	
        	imgBox = new Image(document.form1.viewImage);        	
        	
        	//imgBox2 = new Image(document.form1.viewImage2); 
        	
        	
            fnc_ColEnabled('D');

            // 탭의 초기화면 호출
            fnc_ClickTab(1);

            document.getElementById("txtENO_NO").disabled   = false;

            // 타화면으로부터 호출된 경우 해당 사번으로 인사정보 조회
            if (dsTemp != null) {
            	
                document.getElementById("txtENO_NO").value = dsTemp.eno_no;

                document.getElementById("ImgAddNew").disabled = true;

                fnc_SearchList();
                
            }else {

                document.getElementById("ImgAddNew").disabled = false;

            }

            document.getElementById("txtENO_NM").focus();

        }

        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {

            //이곳에 해당 코딩을 입력 하세요
            if (dsT_CM_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion()) return;
            }

            if (dsTemp != null) {
                window.close();
            }
            else {
            	window.close();
            }

        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
            
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

        var old_i = 0;                 // 탭 번호
        var old_u = 0;                 // 서브탭번호
        var old_enono = '';            // 사번(탭클릭시 현재 입력된 사번과 비교하기 위함)

        /***************************************
         * 입력부의 컬럼의 Disabled 속성 바꿈  *
         ***************************************/
        function fnc_ColEnabled(prop) {

            // 해당 컬럼의 속성을 Enabled로 변경
            if (prop == 'E') {

                document.getElementById("txtNAM_CHI").disabled  = false;
                document.getElementById("txtBIR_YMD").disabled  = false;
                document.getElementById("txtAGE").disabled      = false;
                document.getElementById("cmbBIR_TAG").disabled  = false;
                document.getElementById("txtNAM_ENG").disabled  = false;
                document.getElementById("txtCET_NO").disabled   = false;
                document.getElementById("cmbMF_TAG").disabled   = false;
                document.getElementById("txtHIR_YMD").disabled  = false;
                document.getElementById("txtHEAD_CD").disabled  = false;
                document.getElementById("txtOCC_CD").disabled   = false;
                document.getElementById("txtHIRG_YMD").disabled = false;
                document.getElementById("txtDPT_CD").disabled   = false;
                document.getElementById("txtJOB_CD").disabled   = false;
                document.getElementById("txtTEAM_CD").disabled  = false;
                document.getElementById("txtHOB_CD").disabled   = false;
                document.getElementById("txtDUTY_CD").disabled  = false;
                document.getElementById("txtRETP_YMD").disabled   = false;

                document.getElementById("ImgBirYmd").disabled  = false;
                document.getElementById("ImgHirYmd").disabled  = false;
                document.getElementById("ImgHirgYmd").disabled = false;
                document.getElementById("ImgRetpYmd").disabled = false;

            } else if (prop == 'D') {


            	
                document.getElementById("txtNAM_CHI").disabled  = true;
                document.getElementById("txtBIR_YMD").disabled  = true;
                document.getElementById("txtAGE").disabled      = true;
                document.getElementById("cmbBIR_TAG").disabled  = true;
                document.getElementById("txtNAM_ENG").disabled  = true;
                document.getElementById("txtCET_NO").disabled   = true;
                document.getElementById("cmbMF_TAG").disabled   = true;
                document.getElementById("txtHIR_YMD").disabled  = true;
                document.getElementById("txtHEAD_CD").disabled  = true;
                document.getElementById("txtOCC_CD").disabled   = true;
                document.getElementById("txtHIRG_YMD").disabled = true;
                document.getElementById("txtDPT_CD").disabled   = true;
                document.getElementById("txtJOB_CD").disabled   = true;
                document.getElementById("txtTEAM_CD").disabled  = true;
                document.getElementById("txtHOB_CD").disabled   = true;
                document.getElementById("txtDUTY_CD").disabled  = true;
                document.getElementById("txtRETP_YMD").disabled   = true;

                document.getElementById("ImgBirYmd").disabled  = true;
                document.getElementById("ImgHirYmd").disabled  = true;
                document.getElementById("ImgHirgYmd").disabled = true;
                document.getElementById("ImgRetpYmd").disabled = true;

            }

        }

        /*********************************
         * 탭버튼 클릭시 해당 화면 호출  *
         *********************************/
        function fnc_ClickTab(i) {
        	
            var ENO_NO = document.getElementById('txtENO_NO').value;

            if (ENO_NO == "" && i != 1 && i != 19) {
                alert("사번을 입력하여 화면을 조회하신 후에 작업하시기 바랍니다.");
                return;
            }

            if (dsT_CM_PERSON.CountRow < 1 && i != 1  && i != 19) {
                alert("입력하신 사번으로 화면을 조회하신 후에 작업하시기 바랍니다.");
                return;
            }

            if (dsT_CM_PERSON.RowStatus(dsT_CM_PERSON.RowPosition) == 1 && i != 1) {
                alert("신규작업인 경우 화면을 먼저 저장하신 후에 작업하시기 바랍니다..");
                return;
            }

            fnc_ViewFrame(i);

        }

        /********************************************
         * 탭화면 호출시 관련 jsp 가져와 뿌려준다.  *
         ********************************************/
        function fnc_ViewFrame(i) {

            var ENO_NO = document.getElementById('txtENO_NO').value;
            var iframe = document.getElementById("iframe_"+i);

            // 이전과 다른 탭을 클릭한 경우 이전화면은 보이지 않고, 새로운 화면을 보임
            if (old_i != i && old_i != 0) {

                document.getElementById('view_'+old_i).style.display='none';
            }

            document.getElementById('view_'+i).style.display='inline';

            if (i != 1) {

                if (iframe.src == "about:blank") {

                    // 사번생성은 정규/파견사원구분위한 값 넘겨줌
                    if (i != 19) {
                        iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO;
                    }
                    else {
                        iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO+"&srcid=pira010";
                    }

                } else {

                    // 해당 탭 클릭시 이미 보인 화면이더라도 재조회할 수 있도록 IF 조건 막음
                    // 사번이 변경되는 경우 현재 보여지는 탭의 정보를 다시 가져오기 위함
                        iframe.contentWindow.document.getElementById("ENO_NO").value = ENO_NO;

                        // 사번생성은 재조회 필요없음
                        if (i != 19) {
                            iframe.contentWindow.fnc_SearchList();
                        }

                    //}
                }

            } else {

                fnc_ViewFrameTab(1);

            }

            old_i=i;
            old_enono = ENO_NO;

        }

        /*******************************************************
         * 탭화면안의 서브탭 호출시 관련 jsp 가져와 뿌려준다.  *
         *******************************************************/
        function fnc_ViewFrameTab(u) {

            var ENO_NO = document.getElementById("txtENO_NO").value;
            var iframe = document.getElementById("iframe_tab_"+u);

            // 이전과 다른 탭을 클릭한 경우 이전화면은 보이지 않고, 새로운 화면을 보임
            if (old_u != u && old_u != 0) {

                document.getElementById('view_tab_'+old_u).style.display='none';
            }

            document.getElementById('view_tab_'+u).style.display='inline';

            if (iframe.src == "about:blank") {

              iframe.src = iframe.load_src + "?ENO_NO=" + ENO_NO;
            }
            else {

                // 사번이 변경되는 경우 현재 보여지는 탭의 정보를 다시 가져오기 위함
                if (iframe.contentWindow.document.getElementById("ENO_NO").value != ENO_NO) {

                    iframe.contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
                    iframe.contentWindow.fnc_SearchList();

                }
            }

            old_u=u;

            document.getElementById("resultMessage").innerText = ' ';

        }

        
        
        /*----------------------------------------------------------------------------
    	Description : 사진불러오기
	    ----------------------------------------------------------------------------*/
	    function ln_Photo(ENO_NO){

	    		//photo.src = "../../../Ehr/photo/" + ENO_NO + ".jpg";

	            var f = document.form1;

	            //f.photo.src = "../../../Ehr/photo/" + ENO_NO + ".jpg";
	            
	            //f.photo.src = "../../asanwas/Ehr/photo/" + ENO_NO + ".jpg";
		
	            f.photo.src = "/asanwas/Ehr/file/" + ENO_NO + ".jpg";
					    		
	    		
	    }        
        
        
        /*----------------------------------------------------------------------------
    	Description : 사진 업로드하기
	    ----------------------------------------------------------------------------*/
	    function fnc_PhotoUpload(){
    		
    		var ENO_NO = document.getElementById('txtENO_NO').value;
            var oFile_url = null;
            var oFile_name = null;

			// 파일 첨부용 데이터셋의 헤더 정보 설정.
	        dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");            
            
            fcFILE_UPLOAD.Open();

            oFile_url   = fcFILE_UPLOAD.Value;

            oFile_name  = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            //확인을 클릭했는지 여부 검증
            if(fcFILE_UPLOAD.SelectState != true)
                return false;   

            
            var tmp     = fcFILE_UPLOAD.Value.split(".");
            
            var length  = tmp.length;
            
            var ext     = tmp[length-1].toLowerCase();
            
			//alert(oFile_url);
			//alert(oFile_name);
			//alert(ext);
            
            if(!(length > 0
                    && (   ext == "jpg"
                        || ext == "gif"
                        || ext == "jpeg"
                        || ext == "png"))) {
                alert("jpg 형식의 파일만 업로드 가능합니다.");
                return;
            }
 
            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */

            dsFILE_UPLOAD.AddRow();

            dsFILE_UPLOAD.NameValue(dsFILE_UPLOAD.CountRow, "FILE_URL")  = oFile_url;

            dsFILE_UPLOAD.NameValue(dsFILE_UPLOAD.CountRow, "FILE_NAME") = oFile_name;

            //alert(oFile_url);
            //alert(oFile_name);            
            //파일 첨부와 동시에 서버에 업로드
            fnc_FileUpload();    		

	    }            
      
        
        /**
         * 실제로 파일을 등록시킨다.
         */
        function fnc_FileUpload() {
        	
        	var ENO_NO = document.getElementById('txtENO_NO').value;
        	
            dsFILE_UPLOAD.UseChangeInfo = "false";

            trFILE_UPLOAD.KeyValue = "tr01(I:dsFILE_UPLOAD=dsFILE_UPLOAD)";
            
            trFILE_UPLOAD.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.g.pirg010.cmd.PIRG010CMD&S_MODE=ULD";
        
            //prompt(this, dsFILE_UPLOAD.text);
            
            trFILE_UPLOAD.post();
            
    	    //var f = document.form1;

    	    //f.photo.src="../../images/common/none.jpg";                  
            
            //photo.src="../../images/common/none.jpg";

            alert("사진을 등록합니다.");
            
            ln_Photo(ENO_NO); 

        }	    
        
        /*************************************************************************
         * 서버의 업로드 디렉토리의 이미지를 뿌려주는 User Defined Object
         * - usage : var obj = new Image(이미지테그의ID);
         *               obj.setImage("서버의 이미지파일의 위치및 파일명");
         * 여기서는 안 쓰인듯
         *************************************************************************/
        function Image(imgTag) {
        	 

        	 
            var imgTag = imgTag;


            
            var action = "../../../servlet/JspChannelSVL?cmd=com.shift.gef.generic.cmd.RetrieveGenericImageCMD";

            var imgUrl = "";

            this.setImage = function(imgBox) {
            	
	            imgUrl = imgBox;
	            
	            imgTag.src = action + "&IMAGE=" +imgUrl;
            	
	            //prompt(this, imgTag.src);
            }

        }

        /********************************************************************
         * 조회된 화면에서 사번 변경시 변경된 사번에 대한 내용을 조회해옴
         ********************************************************************/
        function fnc_chkEnoNo() {

            if (dsT_CM_PERSON.CountRow > 0) {

                if (document.getElementById("txtENO_NO").value  == "") {

                    fnc_Clear();
                    return;
                }

                if (document.getElementById("txtENO_NO").value != dsT_CM_PERSON.OrgNameValue(dsT_CM_PERSON.RowPosition, "ENO_NO")) {

                    fnc_SearchList();
                }
            }

        }

        /********************************************************************
         * 사원팝업버튼 클릭시 선택된 사원의 정보를 조회해오도록 한다.
         ********************************************************************/
        function fnc_ClickEmpPopup() {

            fnc_emplPopup('txtENO_NO','txtENO_NM','','','','','2');

            if (document.getElementById("txtENO_NO").value  != "") {
            	
                fnc_SearchList();
                
            }
            
        }


        function fnc_UsrGetEnoNo() {

            if (document.getElementById("txtENO_NM").value  == "") {

                fnc_Clear();
                
                return;
                
            }

            // 정규직 전체
            fnc_GetEnoNo('txtENO_NM', 'txtENO_NO','1','0');

            if (document.getElementById("txtENO_NO").value  == "") {

                fnc_Clear();
                
                return;
                
            }else {

                fnc_SearchList();
                
            }
            
        }

        function fnc_SsnValid(obj) {
        	
            if (obj.value != "") {
            	
                if (!covSsnValidator_validate(removeChar(obj.value,'-'))) {
                	
                    alert("잘못된 주민번호입니다. 확인바랍니다.");
                    
                    return false;
                }
                
            }

            return true;
        }

        
        function fnc_setMfTag() {

            // 성별이 남자인 경우
            if (document.getElementById("txtCET_NO").value.substr(7,1) == '1') {
            	
                dsT_CM_PERSON.NameValue(1, "MF_TAG") = 'M';
                
            }
            
            // 성별이 여자인 경우
            else if (document.getElementById("txtCET_NO").value.substr(7,1) == '2') {
            	
                dsT_CM_PERSON.NameValue(1, "MF_TAG") = 'F';
                
            }
            
        }

        function fnc_TabSave() {
        	
            var ENO_NO = document.getElementById('txtENO_NO').value;
            var tmp_i = 0;
            var tmp_u = 0;
            var Msg = '';

            Msg = document.getElementById("resultMessage").innerText;

            tmp_i = old_i;
            tmp_u = old_u;

            if (old_i != 1) {
                fnc_ViewFrame(1);
            }

            // 인사기본2, 3, 4, 5 변경사항 존재시 저장
            for (var k = 1; k <= 4; k++) {
            	
                var iTabframe = document.getElementById('iframe_tab_'+k);

                if (iTabframe.src != "about:blank") {

                    if (iTabframe.contentWindow.document.getElementById("ENO_NO").value == ENO_NO) {

                        fnc_ViewFrameTab(k);

                        if (!iTabframe.contentWindow.fnc_Save()) {

                            old_u = k;
                            return;
                        }
                        
                    }
                    
                }
                
            }

            if (tmp_i != 1) {
            	
                fnc_ViewFrame(tmp_i);
                
            }else {
            	
                fnc_ViewFrameTab(tmp_u);
                
            }

            if (savflag == '1') {
            	
                fnc_Message(document.getElementById("resultMessage"), "MSG_01");
                
                savflag = '';
                
            }else {
            	
                document.getElementById("resultMessage").innerText = Msg;
                
            }

            old_i = tmp_i;
            old_u = tmp_u;
        }


        //입사일 체크
        var tmpHIR_YMD = "";//fnc_ChgHirYmd()전용 임시변수
        
        function fnc_ChgHirYmd() {

            var i = old_i;

            if (fnc_CheckDate(document.getElementById("txtHIR_YMD"), '입사일') == false) {
               return;
            }

            //입력한 값과 틀리면 변경
            if(event.type != "blur"){

                //달력에서 들어오면 포커스가 오기전에 값이 바뀌므로 입력단에서 공백으로 초기화하게 셋팅해두었다.
                if(tmpHIR_YMD != " "){
                    tmpHIR_YMD = document.getElementById("txtHIR_YMD").value;
                }

            }else{//blur

	            if(tmpHIR_YMD != document.getElementById("txtHIR_YMD").value){
	                document.getElementById("txtHIRG_YMD").value = document.getElementById("txtHIR_YMD").value;
	                tmpHIR_YMD = "";
		        }

            }

        }

        //그룹입사일 체크
        function fnc_ChkHirdYmd() {

            if(document.getElementById("txtHIRG_YMD").value == "" || document.getElementById("txtHIR_YMD").value == ""){
                return ;
            }

            var HIRG_YMD =  document.getElementById("txtHIRG_YMD").value.replace("-","").replace("-","");
            var HIR_YMD =  document.getElementById("txtHIR_YMD").value.replace("-","").replace("-","");

            if (HIRG_YMD > HIR_YMD){
                alert("그룹입사일이 입사일보다 늦을 수 없습니다..");
                document.getElementById("txtHIRG_YMD").value = "";
                document.getElementById("txtHIRG_YMD").focus();
                return;
            }

        }

    </script>
</head>


    <!--********************************************************************
    * 가우스 컴포넌트 선언 및 이벤트 (트랜젝션, 데이터셋) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_CM_PERSON_01                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"              value='첨부파일'>
        <param name="Enable"            value="true">
    </object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>
    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_CM_AHISTORY                     |
    | 3. Table List : T_CM_AHISTORY                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_AHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT00" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT3" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT4" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT5" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>
    
    <Object ID="dsT_RP_REPORT6" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT7" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>

    <Object ID="dsT_RP_REPORT8" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" 				Value="True">
        <Param Name="UseChangeInfo" 		Value="True">
        <Param Name="ViewDeletedRow" 	Value="False">
    </Object>
        
    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름 : trT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        var ENO_NO  = "";
        var FILEURL = "";
        var frame   = "";
        var i = 0;
        var j = 0;
    
        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

            fnc_ColEnabled('D');

        } else {

            fnc_ColEnabled('E');

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_CM_PERSON.CountRow);

        }

        ENO_NO = dsT_CM_PERSON.NameValue(1, "ENO_NO");
        
        FILEURL = "<%=FILEURL%>" + "/" + ENO_NO + ".jpg";

	    imgBox.setImage(FILEURL);

	    //imgBox2.setImage(FILEURL);
	    //f.photo.src = "../../../Ehr/photo/" + ENO_NO + ".jpg";
	    //imgBox.Image(FILEURL);
	    //f.photo.src = "/asanwas/Ehr/photo/" + ENO_NO + ".jpg";
   

	    
        document.getElementById("txtENO_NO").disabled = false;
        document.getElementById("txtENO_NM").focus();

        if (old_i == 0) {
            return;
        }

        // 사번이 변경되는 경우 현재 보여지는 탭의 정보를 다시 가져오고 다른 탭의 사번을 초기화
        // 현재 탭이 기본사항인 경우
        if (old_i == 1) {

            if (old_u == 1 && dsTemp != null && dsTemp.eno_no == ENO_NO) {
                var iframe = document.getElementById("iframe_tab_1");
                iframe.src = "about:blank";
                fnc_ViewFrameTab(1);
            }
            else {
                document.getElementById("iframe_tab_"+old_u).contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
                document.getElementById("iframe_tab_"+old_u).contentWindow.fnc_SearchList();
            }

            if (iCount > 0) {
                document.getElementById("resultMessage").innerText = '';
            }

            // 사번 초기화
            for (i = 1; i <= 4; i++) {

                if (i != old_u && document.getElementById("iframe_tab_"+i).src != "about:blank") {

                    document.getElementById("iframe_tab_"+i).contentWindow.document.getElementById("ENO_NO").value = "";

                }
            }

        }
        else {

            for (i = 1; i <= 4; i++) {

                if (document.getElementById("iframe_tab_"+i).src != "about:blank") {

                    document.getElementById("iframe_tab_"+i).contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
                    document.getElementById("iframe_tab_"+i).contentWindow.fnc_SearchList();

                }
            }

            // 해당 탭 클릭시 이미 보인 화면이더라도 재조회할 수 있도록 IF 조건 막음
                document.getElementById("iframe_"+old_i).contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
                document.getElementById("iframe_"+old_i).contentWindow.fnc_SearchList();

                // 입사후경력 저장후 재조회시 처리 / 급여탭 재조회
                if (old_i == 11 && document.getElementById("iframe_17").src != "about:blank") {

                    document.getElementById("iframe_tab_1").contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
                    document.getElementById("iframe_tab_1").contentWindow.fnc_SearchList();

                    document.getElementById("iframe_17").contentWindow.document.getElementById("ENO_NO").value = ENO_NO;
                    document.getElementById("iframe_17").contentWindow.fnc_SearchList();

                    old_i = 11;

                }


        }

        if (old_enono != ENO_NO) {
            old_enono = ENO_NO;
        }

    </Script>

    <Script For=dsT_CM_PERSON_01 Event="OnLoadCompleted(iCount)">
    
    	if (iCount == 0) {

		} else {
			
			alert("해당 사번이 이미 존재합니다.");
			
			document.getElementById("txtENO_NO").value = "";
			
            document.getElementById("txtENO_NO").focus();

		}

    </Script>

    <Script For=dsT_CM_AHISTORY Event="OnLoadCompleted(iCount)">

		if (iCount == 0) {

			if(ahiflag == "SAV"){
				
				alert("저장이 완료되었습니다. 입사후경력을 입력해주세요.");
				
			}else if(ahiflag == "SHR"){
				
				alert("입사후경력이 없습니다. 입사후경력을 입력해주세요.");
				
			}
			
			ahiflag = "";

			fnc_ClickTab(11);

		} else {

		}

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_CM_PERSON_01 Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <Script For=dsT_CM_AHISTORY Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        //Dataset관련 Error 처리
        if (this.ErrorCode == 50018 ) {
        	
            alert("해당 필수입력항목[사번] 입력 후 다음 작업이 가능합니다.");
            
        }else if (this.ErrorCode == 50019) {
        	
            alert("사번에 대한 중복값이 존재합니다. 확인바랍니다.");
            
        }else {
        	
            cfErrorMsg(this);
            
        }

    </Script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">

        fnc_Message(document.getElementById("resultMessage"), "MSG_01");

        fnc_TabSave();

    </script>

    <!-----------------------------+
    | Transaction Successful 처리  |
    +------------------------------>
    <script for=trFILE_UPLOAD event="OnSuccess()">

    	//fnc_SearchList();

    </script>

    <!--------------------------+
    | Transaction Failure 처리  |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">

        cfErrorMsg(this);
        
        document.getElementById("REG_NO").value = '';

    </script>

	<script language="javascript" for="photo" event=onerror>

		   //photo.src="../../images/common/none.jpg";

	            var f = document.form1;

	            f.photo.src="../../images/common/none.jpg";	   
		   
	</script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>



<!-- form 시작 -->
<form name="form1">



<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="140"></col>
                    <col width="75 "></col>
                    <col width="145"></col>
                    <col width="75 "></col>
                    <col width="145"></col>
                    <col width="80 "></col>
                    <col width="140"></col>
                </colgroup>
                <tr>
                    <td class="padding2423" colspan="7">
                    <!-- 탭 버튼 테이블 시작 -->
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                            <tr>
                                <td>
                                    <input type=button id="btnPIRA012" value="기본사항"    style="width:88pt;" onclick="fnc_ClickTab(1)">
                                    <input type=button id="btnPIRA016" value="학력사항"    style="width:88pt;" onclick="fnc_ClickTab(2)">
                                    <input type=button id="btnPIRA017" value="병무사항"    style="width:88pt;" onclick="fnc_ClickTab(3)">
                                    <input type=button id="btnPIRA018" value="가족사항"    style="width:88pt;" onclick="fnc_ClickTab(4)">
                                    <input type=button id="btnPIRA019" value="건강검진"    style="width:88pt;" onclick="fnc_ClickTab(5)">
                                    <input type=button id="btnPIRA020" value="자격면허"    style="width:88pt;" onclick="fnc_ClickTab(6)">
                                    <input type=button id="btnPIRA023" value="북측출장"    style="width:88pt;" onclick="fnc_ClickTab(9)">
                                    <input type=button id="btnPIRA032" value="사번생성"    style="width:88pt;" onclick="fnc_ClickTab(19)">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type=button id="btnPIRA024" value="입사전경력"  style="width:88pt;" onclick="fnc_ClickTab(10)">
                                    <input type=button id="btnPIRA025" value="입사후경력"  style="width:88pt;" onclick="fnc_ClickTab(11)">
                                    <input type=button id="btnPIRA026" value="상벌사항"    style="width:88pt;" onclick="fnc_ClickTab(12)">
                                    <input type=button id="btnPIRA027" value="어학성적"    style="width:88pt;" onclick="fnc_ClickTab(13)">
                                    <input type=button id="btnPIRA028" value="교육사항"    style="width:88pt;" onclick="fnc_ClickTab(14)">
                                    <input type=button id="btnPIRA030" value="공조부조"    style="width:88pt;" onclick="fnc_ClickTab(16)">
                                    <input type=button id="btnPIRA031" value="급여변경"    style="width:88pt;" onclick="fnc_ClickTab(17)">
                                    <input type=button id="btnPIRA033" value="사회공헌"    style="width:88pt;" onclick="fnc_ClickTab(20)">
                                </td>
                            <tr>
                        </table>
                    <!-- 탭 버튼 테이블 끝 -->
                    </td>
                </tr>
                <tr>

	                <!-- 사진 이미지 -->
                    <td align="center" rowSpan="7">
                    
                    <img id="viewImage" src="init" border="0" width="125" height="167" onerror="this.src='../../images/common/none.jpg';">
                    <!--  
							<img id="photo" src="photo.src" border="0" width="125px" height="167px" style="position: relative; top: 2px"/>
							<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"> -->
							<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="15" height="15" border="0" style="position: relative; top: 150px" onclick="fnc_PhotoUpload();"></a>							
					
					
					
							</td>
                    <td align="center" class="blueBold">사&nbsp;&nbsp;&nbsp;&nbsp;번</td>
                    <td class="padding2423">
                        <input type=hidden id="REG_NO">
                        <input id="txtENO_NO" size="10" maxlength="8" style="ime-mode:disabled" onChange="fnc_chkEnoNo();" onKeyPress="JavaScript:cfNumberCheck();if(event.keyCode == 13){document.getElementById('txtENO_NO').focus();fnc_SearchList();}">
                    </td>
                    <td align="center" class="blueBold">국문성명</td>
                    <td class="padding2423">
                        <input id="txtENO_NM" maxlength="12" style="width:80%; ime-mode: active" onKeyPress="JaveScript: if (event.keyCode == 13) {fnc_UsrGetEnoNo();}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup()"></a>
                    </td>
                    <td align="center" class="blueBold">한자성명</td>
                    <td class="padding2423">
                        <input id="txtNAM_CHI" maxlength="12" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">생년월일</td>
                    <td class="padding2423">
                        <input id="txtBIR_YMD" style="width:51%;ime-mode:disabled" maxlength="10" onChange="fnc_CheckDate(this, '생년월일');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgBirYmd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgBirYmd" name="ImgBirYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtBIR_YMD','','145','125');"></a>
                        <input id="txtAge" style="width:14%" class="input_ReadOnly" readonly>세
                    </td>
                    <td align="center" class="blueBold">구&nbsp;&nbsp;&nbsp;&nbsp;분</td>
                    <td class="padding2423">
                        <select id="cmbBIR_TAG" style="width:100%" >
                            <option value="S">양력</option>
                            <option value="M" >음력</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">영문성명</td>
                    <td class="padding2423">
                        <input id="txtNAM_ENG" maxlength="20" style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">주민번호</td>
                    <td class="padding2423">    <input id="txtCET_NO" maxlength="14" style="width:100%;ime-mode:disabled" onKeyPress="JavaScript: cfCetNoHyphen(this);cfNumberCheck();" onChange="javascript : if (fnc_SsnValid(this) == true) {fnc_setMfTag();}" ></td>
                    <td align="center" class="blueBold">성&nbsp;&nbsp;&nbsp;&nbsp;별</td>
                    <td class="padding2423">
                        <select id="cmbMF_TAG" style="width:100%" >
                            <option value="M">남자</option>
                            <option value="F" >여자</option>
                        </select>
                    </td>
                    <td align="center" class="blueBold">입&nbsp;사&nbsp;일</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onblur="fnc_ChgHirYmd();" onfocus="fnc_ChgHirYmd();" onkeypress="cfDateHyphen(this);cfCheckNumber();" onkeydown="if(event.keyCode==9){txtJPR_YMD.focus();event.returnValue=false;}">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirYmd','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgHirYmd" name="ImgHirYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHIR_YMD','','750','200');tmpHIR_YMD = ' ';"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">본&nbsp;&nbsp;&nbsp;&nbsp;부</td>
                    <td class="padding2423">
                        <input id="txtHEAD_CD" style="width:15%" maxlength="2"  class="input_ReadOnly"  readonly> <input id="txtHEAD_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">근로구분</td>
                    <td class="padding2423">
                        <input id="txtOCC_CD" name="txtOCC_CD" style="width:15%" maxlength="2"  class="input_ReadOnly"  readonly> <input id="txtOCC_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">그룹입사일</td>
                    <td class="padding2423">
                        <input id="txtHIRG_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onBlur="fnc_ChkHirdYmd();" onChange="fnc_CheckDate(this, '그룹입사일');"  onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHirgYmd','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgHirgYmd" name="ImgHirgYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtHIRG_YMD','','750','200');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">소&nbsp;&nbsp;&nbsp;&nbsp;속</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" style="width:15%" maxlength="2"  class="input_ReadOnly"  readonly> <input id="txtDPT_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">직&nbsp;&nbsp;&nbsp;&nbsp;위</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" style="width:15%" maxlength="2"  class="input_ReadOnly"  readonly> <input id="txtJOB_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">승&nbsp;진&nbsp;일</td>
                    <td class="padding2423">
                        <input id="txtJPR_YMD" style="width:78%;ime-mode:disabled" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onkeydown="if(event.keyCode==9){event.returnValue=false;}">
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgJprYmd','','../../images/button/btn_HelpOver.gif',1)">
						<img src="../../images/button/btn_HelpOn.gif" id="ImgJprYmd" name="ImgJprYmd" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtJPR_YMD','','750','200');"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">&nbsp;&nbsp;&nbsp;파&nbsp;&nbsp;&nbsp;&nbsp;트&nbsp;&nbsp;&nbsp;</td>
                    <td class="padding2423">
                        <input id="txtTEAM_CD" style="width:15%" maxlength="2"  class="input_ReadOnly"  readonly> <input id="txtTEAM_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">년&nbsp;&nbsp;&nbsp;&nbsp;차</td>
                    <td class="padding2423">
                        <input id="txtHOB_CD" style="width:15%" maxlength="2"  class="input_ReadOnly"  readonly>&nbsp;<input id="txtHOB_NM" style="width:60%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgHOB_CD','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgHOB_CD" name="ImgHOB_CD"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtHOB_CD','txtHOB_NM','년차','A4')"></a>
                    </td>
                    <td align="center" class="blueBold">계약만료일</td>
                    <td class="padding2423">
                        <input id="txtRETP_YMD" style="width:78%" maxlength="10" >
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgRetpYmd','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgRetpYmd" name="ImgRetpYmd"  width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">직&nbsp;&nbsp;&nbsp;&nbsp;책</td>
                    <td class="padding2423">
                        <input id="txtDUTY_CD" style="width:15%" maxlength="2"  class="input_ReadOnly"  readonly> <input id="txtDUTY_NM" style="width:80%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">회계소속</td>
                    <td class="padding2423">
                        <input id="txtTAX_DPT" style="width:15%" maxlength="6"  class="input_ReadOnly"  readonly> <input id="txtTAX_DPTNM" style="width:60%" class="input_ReadOnly"  readonly>
                         <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTAX_DPT','','../../images/button/btn_HelpOver.gif',1)">
                         <img src="../../images/button/btn_HelpOn.gif" id="ImgTAX_DPT" name="ImgTAX_DPT"  width="21" height="20" border="0" align="absmiddle" onClick="fnc_commonCodePopup('txtTAX_DPT','txtTAX_DPTNM','회계부서코드','AD')"></a>
                    </td>
                    <td align="center" class="blueBold">직&nbsp;&nbsp;&nbsp;&nbsp;종</td>
                    <td class="padding2423">
                        <input id="txtJIKMU" style="width:100%" class="input_ReadOnly"  readonly >
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조건 입력 테이블 끝 -->

<!-- 기본사항 시작 -->
<div id="view_1" style="border-style:solid;border-color:#999999;border-width:0;display:none">
<table width="1000" height="294" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
    <tr><td align="center">
        <input type=hidden id="ENO_NO" size="10">
        <!-- 탭 버튼 테이블 시작 -->
        <table width="996" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop5">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <tr>
                            <td align="left">
                                <input type=button id="btn2" value="인사기본2"      onclick="fnc_ViewFrameTab(1)">
                                <input type=button id="btn3" value="인사기본3"      onclick="fnc_ViewFrameTab(2)">
                                <input type=button id="btn4" value="인사기본4"      onclick="fnc_ViewFrameTab(3)">
                                <input type=button id="btn5" value="인사기본5"      onclick="fnc_ViewFrameTab(4)">
                                <input type=hidden id="ENO_NO" size="10">
                            </td>
                        <tr>
                    </table>
                </td>
            </tr>
        </table>
        <!-- 탭 버튼 테이블 끝 -->

        <!-- 인사기본2 시작 -->
        <div id="view_tab_1" style="width:996;height:264;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_1" src="about:blank" load_src="../../../Ehr/hr/pir/pira012.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- 인사기본2 끝 -->

        <!-- 인사기본3 시작 -->
        <div id="view_tab_2" style="width:996;height:264;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_2" src="about:blank" load_src="../../../Ehr/hr/pir/pira013.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- 인사기본3 끝 -->

        <!-- 인사기본4 시작 -->
        <div id="view_tab_3" style="width:996;height:264;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_3" src="about:blank" load_src="../../../Ehr/hr/pir/pira014.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- 인사기본4 끝 -->

        <!-- 인사기본5 시작 -->
        <div id="view_tab_4" style="width:996;height:264;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_4" src="about:blank" load_src="../../../Ehr/hr/pir/pira015.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- 인사기본5 끝 -->
    </td></tr>
</table>
</div>
<!-- 인사기본2 끝 -->

<!-- 학력사항 시작 -->
<div id="view_2" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_2" src="about:blank" load_src="../../../Ehr/hr/pir/pira016.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 학력사항 끝 -->

<!-- 병무사항 시작 -->
<div id="view_3" style="width:1000;height:100;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_3" src="about:blank" load_src="../../../Ehr/hr/pir/pira017.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 병무사항 끝 -->

<!-- 가족사항 시작 -->
<div id="view_4" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_4" src="about:blank" load_src="../../../Ehr/hr/pir/pira018.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 가족사항 끝 -->

<!-- 건강검진 시작 -->
<div id="view_5" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_5" src="about:blank" load_src="../../../Ehr/hr/pir/pira019.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 건강검진 끝 -->

<!-- 자격면허 시작 -->
<div id="view_6" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_6" src="about:blank" load_src="../../../Ehr/hr/pir/pira020.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 자격면허 끝 -->

<!-- 출장 시작 -->
<div id="view_9" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_9" src="about:blank" load_src="../../../Ehr/hr/pir/pira023.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 출장 끝 -->

<!-- 입사전경력 시작 -->
<div id="view_10" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_10" src="about:blank" load_src="../../../Ehr/hr/pir/pira024.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 입사전경력 끝 -->

<!-- 입사후경력 시작 -->
<div id="view_11" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_11" src="about:blank" load_src="../../../Ehr/hr/pir/pira025.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 입사후경력 끝 -->

<!-- 상벌사항 시작 -->
<div id="view_12" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_12" src="about:blank" load_src="../../../Ehr/hr/pir/pira026.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 상벌사항 끝 -->

<!-- 어학성적 시작 -->
<div id="view_13" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_13" src="about:blank" load_src="../../../Ehr/hr/pir/pira027.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 어학성적 끝 -->

<!-- 교육사항 시작 -->
<div id="view_14" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_14" src="about:blank" load_src="../../../Ehr/hr/pir/pira028.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 교육사항 끝 -->

<!-- 행사참여 시작 -->
<div id="view_15" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_15" src="about:blank" load_src="../../../Ehr/hr/pir/pira029.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 행사참여 끝 -->

<!-- 공조부조 시작 -->
<div id="view_16" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_16" src="about:blank" load_src="../../../Ehr/hr/pir/pira030.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 공조부조 끝 -->

<!-- 급여변경 시작 -->
<div id="view_17" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_17" src="about:blank" load_src="../../../Ehr/hr/pir/pira031.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 급여변경 끝 -->

<!-- 사회공헌 시작 -->
<div id="view_20" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_20" src="about:blank" load_src="../../../Ehr/hr/pir/pira034.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 사회공헌 끝 -->

<!-- 사번생성 시작 -->
<div id="view_19" style="width:1000;height:400;border-style:solid;border-color:#999999;border-width:1;display:none;">
<iframe id="iframe_19" src="about:blank" load_src="../../../Ehr/hr/pir/pira032.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
</div>
<!-- 사번생성 끝 -->

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width=100%><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 조회 상태 테이블 끝 -->


</form>
 <!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 






<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N   -   #### 인사기록카드 ####
------------------------------------------------------------------------------>

<OBJECT id=ReportID  classid=clsid:CC26E2A9-760B-4EA6-8DDF-DB423FD24089 VIEWASTEXT>
	<PARAM NAME="MasterDataID"						VALUE="dsT_RP_REPORT00">
	<param name="DetailDataID"	    				value="dsT_RP_REPORT">
	<PARAM NAME="PaperSize"							VALUE="A4">
	<PARAM NAME="LandScape"							VALUE="1">
  	<PARAM NAME="PrintSetupDlgFlag" 				VALUE="true">
	<PARAM NAME="PreviewZoom"						VALUE="100">
    <param name="MargineX"                      	value="10">
    <param name="MargineY"                      	value="10">    
	<PARAM NAME="Format" 							VALUE="

">
</OBJECT>




<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- 달성도배점설정 테이블 -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C>Col=ENO_NO         Ctrl=txtENO_NO      Param=value Disable=disabled</C>
        <C>Col=ENO_NM         Ctrl=txtENO_NM      Param=value </C>
        <C>Col=NAM_CHI        Ctrl=txtNAM_CHI     Param=value </C>
        <C>Col=BIR_YMD        Ctrl=txtBIR_YMD     Param=value </C>
        <C>Col=AGE            Ctrl=txtAGE         Param=value </C>
        <C>Col=BIR_TAG        Ctrl=cmbBIR_TAG     Param=value </C>
        <C>Col=NAM_ENG        Ctrl=txtNAM_ENG     Param=value </C>
        <C>Col=CET_NO         Ctrl=txtCET_NO      Param=value </C>
        <C>Col=MF_TAG         Ctrl=cmbMF_TAG      Param=value </C>
        <C>Col=HIR_YMD        Ctrl=txtHIR_YMD     Param=value </C>
        <C>Col=HEAD_CD        Ctrl=txtHEAD_CD     Param=value </C>
        <C>Col=HEAD_NM        Ctrl=txtHEAD_NM     Param=value </C>
        <C>Col=OCC_CD         Ctrl=txtOCC_CD      Param=value </C>
        <C>Col=OCC_NM         Ctrl=txtOCC_NM      Param=value </C>
        <C>Col=HIRG_YMD       Ctrl=txtHIRG_YMD    Param=value </C>
        <C>Col=DPT_CD         Ctrl=txtDPT_CD      Param=value </C>
        <C>Col=DPT_NM         Ctrl=txtDPT_NM      Param=value </C>
        <C>Col=JOB_CD         Ctrl=txtJOB_CD      Param=value </C>
        <C>Col=JOB_NM         Ctrl=txtJOB_NM      Param=value </C>
        <C>Col=JPR_YMD        Ctrl=txtJPR_YMD     Param=value </C>
        <C>Col=TEAM_CD        Ctrl=txtTEAM_CD     Param=value </C>
        <C>Col=TEAM_NM        Ctrl=txtTEAM_NM     Param=value </C>
        <C>Col=HOB_CD         Ctrl=txtHOB_CD      Param=value </C>
        <C>Col=HOB_NM         Ctrl=txtHOB_NM      Param=value </C>
        <C>Col=HBA_YMD        Ctrl=txtHBA_YMD     Param=value </C>
        <C>Col=DUTY_CD        Ctrl=txtDUTY_CD     Param=value </C>
        <C>Col=DUTY_NM        Ctrl=txtDUTY_NM     Param=value </C>
        <C>Col=TAX_DPT        Ctrl=txtTAX_DPT     Param=value </C>
        <C>Col=TAX_DPTNM      Ctrl=txtTAX_DPTNM   Param=value </C>
        <C>Col=RETP_YMD       Ctrl=txtRETP_YMD    Param=value </C>
        <C>Col=JIKMU          Ctrl=txtJIKMU       Param=value </C>
    '>
</object>


