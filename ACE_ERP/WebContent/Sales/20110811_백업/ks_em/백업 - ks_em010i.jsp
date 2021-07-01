
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>
<% String dirPath = request.getContextPath(); 
	java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());		
%>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 개성 로력 인사관리 - 기본정보
+ 기능정의 : 인사 기본정보를 화면 하단의 3개의 텝을 이용하여 입력,수정,삭제,조회한다.
+ 프로그램ID : ks_em010i.jsp
+ 기능정의 : 
+ 작 성 자 : 이 동 훈
+ 작성일자 : 2008.07.22
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : KS_Em010_S1,      KS_Em010_S2
----------------------------------------------------------------------------------*/
%>

<!-- HTML 시작-->
	<html xmlns="http://www.w3.org/1999/xhtml"><head>

    <jsp:include page="/Sales/common/include/head.jsp" />
<%
/*=============================================================================
				Developer Java Script 시작
=============================================================================*/
%>
	<script language="javascript">

	get_cookdata();
	var useid = gusrid;
	//로컬에서 사용하기 위해 임의로 막음.
    /*
	var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	var year_date = gcurdate.substring(2,4);
	*/
	
	var gs_date = '<%=firstday%>';
	var year_date = gs_date.substring(2,4);
	var chk_tab = "";

	/*----------------------------------------------------------------------------
	 * 페이지로딩
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload 시 호출되는 함수!!!!!

			fnInit_tree(tree_idx);	//트리초기화 호출 [반드시 들어가야 함]			
			window.status="완료";
			ln_SetDataHeader();//gcds_data00 해더생성
			txt_nm.focus();
		}

/*----------------------------------------------------------------------------
	Description : 팝업창
----------------------------------------------------------------------------*/
function ln_Find(){
		if(gcds_data00.countrow<1){
			ln_Find_s();
		}else{
					if(gcds_data00.SysStatus(gcds_data00.RowPosition)=='1' || gcds_data00.SysStatus(gcds_data00.RowPosition)=='3'){
							alert("먼저 저장해 주세요.");
							return;
					}else{	ln_Find_s();	}
		}
}

//근로자 정보-----------------------------------------------------------------------
	function ln_Find_s(){

		var arrResult	= new Array();
		var strURL;
		var strPos;

		strURL = "../popup/ks_em_popup.jsp";
		strPos = "dialogWidth:480px;dialogHeight:400px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);

		if (arrResult != null) {
			gcds_data00.addrow();
			arrParam = arrResult.split(";");
			gcem_empnmk.Text=arrParam[0];
			gcem_cust_sid.Text=arrParam[1];
			gcem_birthday.Text=arrParam[2];
			gcra_sex.codevalue=arrParam[3];
			gcem_pass_no.Text=arrParam[4];
			gcem_pass_epdate.Text=arrParam[5];
			gcem_n_card_no.Text=arrParam[6];
			gclx_nation_cd.bindcolval=arrParam[7];
			txt_tel_no.value=arrParam[8];
			txt_mobile_no.value=arrParam[9];
			txt_zipcd.value=arrParam[10];
			txt_address1.value=arrParam[11]&&arrParam[12];
			//txt_address2.value=arrParam[12];
			txt_usts.value=arrParam[13];
			gcem_eng_nm.Text=arrParam[14];
			gclx_ord_cd.bindcolval="001"; //신규입사
			gcem_con_year.text=1;
 
		}
}

 /*-----------------------------------------------------------------------------
	Description : Dataset Head 설정 - gcds_data00
-----------------------------------------------------------------------------*/
	function ln_SetDataHeader(){
			if(gcds_data00.countrow<1){
				var s_temp = "CUST_SID:DECIMAL(10),USESTS:STRING(1),EMPNMK:STRING(30),EMPNMC:STRING(20),LAST_NM:STRING(30),"
									 + "FIRST_NM:STRING(30),EMPNO:STRING(10),BIRTHDAY:STRING(8),SEX:STRING(1),NATION_CD:STRING(3),"
									 + "START_DT:STRING(8),JOB_CD:STRING(5),AGENCY_CD:STRING(3),VEND_CD:DECIMAL(10),DEPT_CD:STRING(5),"
									 + "TEAM_CD:STRING(5),WORK_CD:STRING(5),SKILL_CD:STRING(5),COUNTRY_CD:STRING(3),PASS_NO:STRING(20),"
									 + "PASS_EXPIRE_DATE:STRING(8),CON_YEAR:DECIMAL(2),I_DATE:STRING(10),U_DATE:STRING(10),I_EMPNO:STRING(10),"
									 + "U_EMPNO:STRING(10),N_CARD_NO:STRING(20),USTS:STRING(1),ZIP_ADD:STRING(86),ZIP_CD:STRING(6),"
									 + "ADDRESS1:STRING(80),ADDRESS2:STRING(60),TEL_NO:STRING(20),MOBILE_NO:STRING(20),HEIGHT:DECIMAL(4.1),"
									 + "WEIGHT:DECIMAL(4),SIZE_UP:STRING(3),SIZE_DN:STRING(3),SIZE_FT:DECIMAL(3),SIZE_WT:DECIMAL(3),"
									 + "BLOOD:STRING(1),ENG_NM:STRING(60),B_SKILL_CD:STRING(3),ORD_CD:STRING(3),"
									 + "END_DT:STRING(8),CHGYMD:STRING(8),C_VEND_CD:DECIMAL(10),CHI_NM:STRING(30),CHI_RNM:STRING(20),"
									 + "CHI_TEL:STRING(20),CHI_ADD:STRING(50),SCH_FR:STRING(6),SCH_TO:STRING(6),ATT_CD:STRING(2),ATT_NM:STRING(30),"
									 + "SCH_NM:STRING(30),HOBBY:STRING(30),SPC_NM:STRING(30),B_PAY:DECIMAL(10),MANAGE_NO:STRING(20),"
									 + "REM_BNK:STRING(3),SAV_NM:STRING(20),SAV_TEL:STRING(20),REM_ACC:STRING(30),PIC_DIR:STRING(120),"
									 + "WORK_NM:STRING(30),JOB_NM:STRING(30),AGENCY_NM:STRING(30),"
									 + "ORD_NM:STRING(30),COUNTRY_NM:STRING(30),NATION_NM:STRING(30),SEX_NM:STRING(30),REM_BNK_NM:STRING(30),SCH_FRTO:STRING(30),TEAM_NM:STRING(50)";
				gcds_data00.SetDataHeader(s_temp);
		}
	}

/*-----------------------------------------------------------------------------
	Description : PrintDataset Head 설정 - gcds_data00
-----------------------------------------------------------------------------*/
function ln_SetPrintDataHeader(){
		if(gcds_report0.countrow<1){
			var s_temp = "CUST_SID:DECIMAL(10),USESTS:STRING(1),EMPNMK:STRING(30),EMPNMC:STRING(20),LAST_NM:STRING(30),"                
								 + "FIRST_NM:STRING(30),EMPNO:STRING(10),BIRTHDAY:STRING(8),SEX:STRING(1),NATION_CD:STRING(3),"                   
								 + "START_DT:STRING(8),JOB_CD:STRING(5),AGENCY_CD:STRING(3),VEND_CD:DECIMAL(10),DEPT_CD:STRING(5),"               
								 + "TEAM_CD:STRING(5),WORK_CD:STRING(5),SKILL_CD:STRING(5),COUNTRY_CD:STRING(3),PASS_NO:STRING(20),"              
								 + "PASS_EXPIRE_DATE:STRING(8),CON_YEAR:DECIMAL(2),I_DATE:STRING(10),U_DATE:STRING(10),I_EMPNO:STRING(10),"       
								 + "U_EMPNO:STRING(10),N_CARD_NO:STRING(20),USTS:STRING(1),ZIP_ADD:STRING(86),ZIP_CD:STRING(6),"                                     
								 + "ADDRESS1:STRING(80),ADDRESS2:STRING(60),TEL_NO:STRING(20),MOBILE_NO:STRING(20),HEIGHT:DECIMAL(4.1),"            
								 + "WEIGHT:DECIMAL(4),SIZE_UP:STRING(3),SIZE_DN:STRING(3),SIZE_FT:DECIMAL(3),SIZE_WT:DECIMAL(3),"                 
								 + "BLOOD:STRING(1),ENG_NM:STRING(60),B_SKILL_CD:STRING(3),ORD_CD:STRING(3),"                                     
								 + "END_DT:STRING(8),CHGYMD:STRING(8),C_VEND_CD:DECIMAL(10),CHI_NM:STRING(30),CHI_RNM:STRING(20),"                
								 + "CHI_TEL:STRING(20),CHI_ADD:STRING(50),SCH_FR:STRING(6),SCH_TO:STRING(6),ATT_CD:STRING(2),ATT_NM:STRING(30),"  
								 + "SCH_NM:STRING(30),HOBBY:STRING(30),SPC_NM:STRING(30),B_PAY:DECIMAL(10),MANAGE_NO:STRING(20),"                 
								 + "REM_BNK:STRING(3),SAV_NM:STRING(20),SAV_TEL:STRING(20),REM_ACC:STRING(30),PIC_DIR:STRING(120),"
								 + "WORK_NM:STRING(30),JOB_NM:STRING(30),AGENCY_NM:STRING(30),"
								 + "ORD_NM:STRING(30),COUNTRY_NM:STRING(30),NATION_NM:STRING(30),SEX_NM:STRING(30),REM_BNK_NM:STRING(30),SCH_FRTO:STRING(30),TEAM_NM:STRING(50),CUR_DT:STRING(8)";

			gcds_report0.SetDataHeader(s_temp);
	}
}

/*----------------------------------------------------------------------------
	Description : 기본조회
----------------------------------------------------------------------------*/
function ln_Query(){

	photo.src="../common/img/00000.gif";
	gcte_disp.ActiveIndex = 1;
	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>KS_Em010_S1?"
											 + "v_str1=" + gclx_usts.bindcolval
											 + "&v_str2=" + gclx_cmsosok.bindcolval
											 + "&v_str3=" + txt_nm.value;
	gcds_data00.Reset();
	

  	prompt(this,gcds_data00.DataID);

}

/*----------------------------------------------------------------------------
	Description : 사내경력 조회
----------------------------------------------------------------------------*/
function ln_OrdQuery() {

	gcds_data02.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>KS_Em010_S2?"
										 + "v_str1=" + txt_empno.value;
	gcds_data02.Reset();
}

/*----------------------------------------------------------------------------
	Description : 휴가 조회
----------------------------------------------------------------------------*/
function ln_VacQuery() {

	gcds_data06.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>KS_Em010_S6?"
											 + "v_str1=" + txt_empno.value;
	gcds_data06.Reset();
}


/*----------------------------------------------------------------------------
		Description : 추가 - 인사마스터
----------------------------------------------------------------------------*/
	function ln_Add(e){
			if(e=='01'){
				  //2008.05.08.임시로 추가함.
					gcds_data00.addrow();
					var row = gcds_data00.rowposition;
					gcem_pass_no.ReadOnly =false;
					gcem_pass_no.Enable=true;
					gclx_ord_cd.ReadOnly =false;
					gclx_ord_cd.Enable=true;
          gclx_ord_cd.bindcolval='001';
					gcds_data00.namevalue(gcds_data00.rowposition,"USTS")='1';
					gcds_data00.namevalue(gcds_data00.rowposition,"CUST_SID")=0;
					if (row<1) return;
			}else if(e=='03'){          //가족
						gcds_data03.addrow();
			}else if(e=='04'){          //입사전 경력
						gcds_data04.addrow();
			}else if(e=='05'){          //자격면허
						gcds_data05.addrow();
			}else if(e=='10'){          //교육
						gcds_data10.addrow();
			}
	}
/*----------------------------------------------------------------------------
	Description : 저장 - 인사마스터
----------------------------------------------------------------------------*/
function ln_Save(e){
      
      if(!ln_Save_Chk(e)) return; 
			if(e=='01'){ //기본
			    var s_date = gcem_start_dt.text.substring(2,4);
					//prompt('',s_date);
					if (gcds_data00.IsUpdated) {
						 if(confirm("저장하시겠습니까?")){
								gctr_data00.KeyValue = "Em010_T1(I:USER=gcds_data00)";
								gctr_data00.Parameters ="v_str1=9"+s_date+",v_str2="+gusrid;
								gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>KS_Em010_T1";
								prompt('',gcds_data00.text);
								gctr_data00.post();
						 }
					}
			}
}
/*----------------------------------------------------------------------------
	Description : 삭제 - 인사마스터
----------------------------------------------------------------------------*/
function ln_Delete(e){
		if (e=='01') {
				if (confirm("선택한 정보를 삭제하시겠습니까?")) {
						gcds_data00.deleterow(gcds_data00.rowposition);
						gctr_data00.KeyValue = "Em010_T1(I:USER=gcds_data00)";
						gctr_data00.action = "<%=dirPath%><%=HDConstant.PATH_EM%>KS_Em010_T1";
						gctr_data00.post();
				}
		} else if (e=='02') { //사내경력
        if(!ln_Save_Chk(e)) return;
  
				if (confirm("선택한 정보를 삭제하시겠습니까?")) {
						gcds_data02.deleterow(gcds_data02.rowposition);
						gctr_data02.KeyValue = "Em010_T2(I:USER=gcds_data02)";
						gctr_data02.Parameters ="v_str1="+useid;
						gctr_data02.action = "<%=dirPath%><%=HDConstant.PATH_EM%>KS_Em010_T2";
						//prompt('',gcds_data02.text);
						gctr_data02.post();
				}

}

/*----------------------------------------------------------------------------
	Description : 삭제 - 인사마스터
----------------------------------------------------------------------------*/
  function ln_Excel(){
    var szName = "개인정보";
    var szPath = "C:\\Test\\em010i.xls";
       if (gcds_data00.countrow<1){
          alert("다운로드 하실 자료가 없습니다");
       }
       else{
          gcgd_disp.GridToExcel(szName,szPath,2);
       }
   }

/*----------------------------------------------------------------------------
	Description : 저장시 체크
----------------------------------------------------------------------------*/
function ln_Save_Chk(gbn){
	if(gbn=="01"){ //기본정보
		if(gcem_start_dt.text==""){
			alert("입사일을 입력하십시요.");
			return false;
		}
		if(gclx_vend_cd.bindcolval==""){
			alert("근무업체를 입력하십시요.");
			return false;
		}
		if(gclx_dept_cd.bindcolval==""){
			alert("부서를 입력하십시요.");
			return false;
		}
		if(gclx_team_cd.bindcolval==""){
			alert("소속팀을 입력하십시요.");
			return false;
		}
    if(gclx_job_cd.bindcolval==""){
			alert("직종을 입력하십시요.");
			return false;
		}


		if(gclx_c_vend_cd.bindcolval==""){
			alert("비용부담업체를 입력하십시요.");
			return false;
		}
	}else if(gbn=="02"){ //사내경력 삭제시 체크 
		if(gcds_data02.namevalue(gcds_data02.rowposition,"ORD_CD")=="003"){ //
			alert("직종변경은 임의로 삭제 할 수 없습니다.");
			return false;
		}

		if(gcds_data02.namevalue(gcds_data02.rowposition,"ORD_CD")=="001"){ //
			alert("신규입사는 임의로 삭제 할 수 없습니다.");
			return false;
		}
	}else{

	}
	return true;
}


/*----------------------------------------------------------------------------
	Description : 사진불러오기
----------------------------------------------------------------------------*/
function ln_Photo(row){
  //alert("ln_Photo::"+row+"::::"+gcds_data00.namevalue(row,"MANAGE_NO"));
	if(gcds_data00.namevalue(row,"MANAGE_NO")==undefined){
		photo.src="<%=dirPath%>/Sales/images/00000.gif";
	}else{
		var  dirFold = gcds_data00.namevalue(row,"MANAGE_NO").substring(0,1)+"/"; 
		photo.src = "<%=dirPath%>/Sales/file/photo/cust/"+dirFold+gcds_data00.namevalue(row,"MANAGE_NO")+".JPG";
	}
}


/******************************************************************************
	Description : 화일명 체크
******************************************************************************/
function ln_Divide(str, delim){
	var strArr=str.split(delim);
	var rtn="";
	var a=strArr.length;

	if(a>0){rtn=strArr[a-1];}
	strArr=null;
	return rtn;
}


/*----------------------------------------------------------------------------
	Description : 출력하기
----------------------------------------------------------------------------*/
function ln_Print(){
        
    var  dirFold = gcds_data00.namevalue(gcds_data00.rowposition,"MANAGE_NO").substring(0,1)+"/"; 

		//인사기본정보
		gcds_report0.ClearAll();
		ln_SetPrintDataHeader();
  	gcds_report0.ImportData(gcds_data00.ExportData(gcds_data00.rowposition,1,false));
	  gcds_report0.rowposition =  gcds_data00.rowposition;

		gcds_report0.namevalue(gcds_report0.rowposition,"PIC_DIR") = rDOMAIN+"<%=dirPath%>/Sales/file/photo/cust/"+dirFold+gcds_report0.namevalue(gcds_report0.rowposition,"MANAGE_NO")+".JPG";
    gcds_report0.namevalue(gcds_report0.rowposition,"CUR_DT") =gs_date;
      	
		//사내경력
		gcds_report2.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S2?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report2.Reset();

		//가족사항
		gcds_report3.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S3?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report3.Reset();

		//입사전경력
		gcds_report4.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S4?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report4.Reset();

		//자격면허
		gcds_report5.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S5?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report5.Reset();
    
		//휴가
		gcds_report6.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S6?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report6.Reset();
   
		//상벌
		gcds_report7.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S7?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report7.Reset();
  
		//교육
		gcds_report10.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S10?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report10.Reset();
     
		//계약
		gcds_report11.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em010_S11?"
											  + "v_str1=" + txt_empno.value;
	  gcds_report11.Reset();
		
		gcrp_print.preview();
}
</script>
<%/*=============================================================================
				Developer Java Script 끝
=============================================================================*/%>
<%/*=============================================================================
			Gauce Components Event Scripts 시작
=============================================================================*/%>

<script language="javascript" for="gcte_disp" event="onselChanged(index)">
	
	if (gcds_data00.countrow>0) {
		if (index=="2") ln_OrdQuery();        //사내경력 조회
		else if (index=="3")	ln_FamQuery();	//가족사항조회
		else if (index=="4")	ln_CarQuery();	//입사전경력사항조회
		else if (index=="5")	ln_LicQuery();  //자격증사항조회
		else if (index=="6")	ln_VacQuery();  //휴가조회
		else if (index=="10")	ln_ReqQuery();	//교육사항
		else if (index=="11")	ln_DeuQuery();  //고과사항
	}
</script>
<!-- 좌측 그리드 -->
<script language="JavaScript" for="gcds_data00" event="OnRowPosChanged(row)">
    if(row>=1){
			ln_Photo(row);
    }else{
			photo.src="<%=dirPath%>/Sales/images/00000.gif";
		}
		chk_tab = gcte_disp.ActiveIndex;

				if(gcds_data00.SysStatus(gcds_data00.RowPosition)=='1'){//기본화면 풀다운메뉴 신규,기존인지 검색후 잠그고 풀기
						gcra_sex.Enable=false;//sex 필드는 인사마스터가 아니므로 항상 막아놓음.
						gclx_nation_cd.Enable=true;
						//gcem_start_dt.Enable=true;
						gcem_start_dt.readonly=false;
						gcem_end_dt.readonly=false;
						gcem_chgymd.readonly=false;
						gclx_job_cd.Enable=true;
						gclx_agency_cd.Enable=true;
						gclx_vend_cd.Enable=true;
						gclx_dept_cd.Enable=true;
						gclx_team_cd.Enable=true;
						gclx_work_cd.Enable=true;
						//gclx_skill_cd.Enable=true;
						gclx_country_cd.Enable=true;
						gcem_empnmk.Enable=true;
						gcem_empnmc.Enable=true;
						gcem_eng_nm.Enable=true;
						gclx_c_vend_cd.Enable=true;

				}else{
						gcra_sex.Enable=false;//sex 필드는 인사마스터가 아니므로 항상 막아놓음.
						gclx_nation_cd.Enable=false;
						//gcem_start_dt.=false;
            			gcem_start_dt.readonly=true;
						gcem_end_dt.readonly=true;
						gcem_chgymd.readonly=true;
						gclx_job_cd.Enable=false;
						gclx_agency_cd.Enable=false;
						gclx_vend_cd.Enable=false;
						gclx_dept_cd.Enable=false;
						gclx_team_cd.Enable=false;
						gclx_work_cd.Enable=false;
						gclx_skill_cd.Enable=false;
						gclx_country_cd.Enable=false;
						////gcem_empnmk.Enable=false;
						gcem_empnmc.Enable=false;
						gcem_eng_nm.Enable=false;
						////gclx_c_vend_cd.Enable=false;

				}
						if(chk_tab=='2'){
							ln_OrdQuery();//사내경력
						}else if(chk_tab=='3'){
							ln_FamQuery();//가족
						}else if(chk_tab=='4'){
							ln_CarQuery();//입사전경력
						}else if(chk_tab=='5'){
							ln_LicQuery();//자격면허
						}else if(chk_tab=='6'){
							ln_VacQuery();//휴가
						}else if(chk_tab=='10'){
							ln_ReqQuery();//교육
						}else if(chk_tab=='11'){
							ln_DeuQuery();//계약
						}
</script>

<script language="JavaScript" for="gcgd_disp05" event="OnCloseUp(row,colid)">
	if(row>0 && colid=="LCS_TYPE"){
		gcds_cm030.Filter();
	}
</script>

<!-- filter -->
<script language="JavaScript" for="gcds_cm030" event="onFilter(row)">
	if(gcds_data05.namevalue(gcds_data05.rowposition,"LCS_TYPE")!="2"){//자격
		if(gcds_cm030.namevalue(row,"ITEM2")=="1") return true;
		else return false;
	}		

	if(gcds_data05.namevalue(gcds_data05.rowposition,"LCS_TYPE")!="1"){//면허
		if(gcds_cm030.namevalue(row,"ITEM2")=="2") return true;
		else return false;
	}		
</script> 

<script language="JavaScript" for="gclx_job_cd" event="OnSelChange()">
for(i=1;i<=gcds_cm013.countrow;i++){
	if(gcds_cm013.namevalue(i,"COM_CODE")==gcds_cm004.namevalue(gcds_cm004.rowposition,"ITEM2")){
		gclx_skill_cd.index=i-1;
		break;
	}
}
</script>


<%
/*=============================================================================
			Gauce Components Event Scripts 끝
=============================================================================*/
%>


<%/*=============================================================================
			Transaction Component's Event Message Scripts 시작
=============================================================================*/	%>
	<script language="javascript" for="tr1" event="onsuccess()">
	</script>
	<!-- 인사마스터 -->
		<script language="javascript" for="gctr_data00" event="OnSuccess()">
			alert("요청하신 작업을 성공적으로 수행하였습니다.");
		</script>
		<script language="javascript" for="gctr_data00" event="OnFail()">
			alert("Error Code : " + gctr_data00.ErrorCode + "\n" + "Error Message : " + gctr_data00.ErrorMsg + "\n");
		</script>


<%/*=============================================================================
			Transaction Component's Event Message Scripts 끝
=============================================================================*/	%>


<%/*=============================================================================
			DataSet Component's Event Message Scripts 시작
=============================================================================*/%>
<!-- 인사기본 -->
	<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
			document.all.LowerFrame.style.visibility="visible";
	</script>
	<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "조회건수 : " + row + " 건";
			ln_Photo(1);
			if (row <1) {
				alert("검색된 데이터가 없습니다.");
			}else{
			}
	</script>
<!-- 사내경력 -->
			<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt2.innerText = "조회건수 : " + row + " 건";
			if (row <1) {
			alert("검색된 데이터가 없습니다.");
			}
			</script>

<!-- 휴가 -->
			<script language="javascript" for="gcds_data06" event="OnLoadStarted()">
			window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data06" event="onloadCompleted(row,colid)">
			window.status="조회가 완료 되었습니다.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt6.innerText = "조회건수 : " + row + " 건";
			if (row <1) {
			alert("검색된 데이터가 없습니다.");
			}
			</script>

 <script language="JavaScript" for="gcrp_print" event="OnError()">
	alert("Error Code =" + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);
</script>

<script language="JavaScript" for="ds1" event="OnLoadStarted()">
				window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
</script>

<script language="JavaScript" for="ds1" event="OnLoadCompleted(row)">
</script>

<!-- 소속팀 -->
<script language="javascript" for="gcds_cmsosok" event="onloadCompleted(row,colid)">
	gcds_cmsosok.insertrow(1);
	gcds_cmsosok.namevalue(1,"COM_CODE") = "";
	gcds_cmsosok.namevalue(1,"COM_SNAME") = "전체";
	gclx_cmsosok.index = 0;
</script>

<script language="javascript" for="photo" event="onerror">
	   photo.src="<%=dirPath%>/Sales/images/00000.gif";
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts 끝
=============================================================================*/
%>

<%
/*=============================================================================
			DataSet Components(DS) 선언 시작
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	<object id="ds1" classid="<%=HDConstant.CT_DATASET_CLSID%>">
	    <param name="SyncLoad" value="False" />
	</object>
	<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_data00" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_data02" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_data06" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>



<!-- 공통코드 DataSet 선언 ------------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gcds_cm019" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_cm007" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_cm004" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_cm006" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_cm013" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_cm003" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_cmsosok" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_cm020" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
	<param name="SortExpr" value="+COM_SNAME" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_cu003" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_cm005" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_Rv006" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_CM021" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_CM022" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_CM023" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_CM011" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%><object id="gcds_CM008" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%><object id="gcds_CM009" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object><%=HDConstant.COMMENT_END%>
<%=HDConstant.COMMENT_START%>
<object id="gcds_CM010" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object>
<object id="gcds_cm024" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object>

<object id="gcds_cm012" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object>
<object id="gcds_tsy010" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object>

<object id="gcds_cm027" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object>

<object id="gcds_cm028" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object>

<!-- 자격면허구분 -->
<object id="gcds_cm029" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object>
<!-- 자격면허 -->
<object id="gcds_cm030" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
	<param name="UseFilter" value="true" />
</object>
<!-- 교육이수구분 -->
<object id="gcds_cm031" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object>

<object id="gcds_report0" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="false" />
</object>
<object id="gcds_report2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object>
<object id="gcds_report3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object>
<object id="gcds_report4" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object>
<object id="gcds_report5" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object>
<object id="gcds_report6" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object>
<object id="gcds_report7" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object>
<object id="gcds_report8" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object>
<object id="gcds_report9" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object>
<object id="gcds_report10" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object>
<object id="gcds_report11" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49">
	<param name="SyncLoad" value="true" />
</object>
<%=HDConstant.COMMENT_END%>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 인사마스터 -->
<%=HDConstant.COMMENT_START%><object id="gctr_data00" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F">
	<param name="KeyName" value="toinb_dataid4" />
</object><%=HDConstant.COMMENT_END%>

<!-- 사내경력 -->
<%=HDConstant.COMMENT_START%><object id="gctr_data02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F">
	<param name="KeyName" value="toinb_dataid4" />
</object><%=HDConstant.COMMENT_END%>

<!-- 휴가 -->
<%=HDConstant.COMMENT_START%><object id="gctr_data06" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F">
	<param name="KeyName" value="toinb_dataid4" />
</object><%=HDConstant.COMMENT_END%>

<%
/*=============================================================================
			DataSet Components(DS) 선언 끝
=============================================================================*/
%>
</head>

<jsp:include page="/Common/sys/body_s.jsp" flush="true" />

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<body><table border="0" cellpadding="0" cellspacing="0" width="829" height="495" bordercolor="orange">
	<tbody><tr height="20px">
		<td align="left" colspan="3"><!-- 버튼 영역 시작-->
		<table width="825" border="0" cellspacing="0" cellpadding="0">
						<tbody><tr>
							<td align="right" height="30px">		
							  	<img src="<%=dirPath%>/Sales/images/n_create.gif" style="cursor: hand" onclick="ln_Find('01')" />
                				<img src="<%=dirPath%>/Sales/images/refer.gif" style="cursor: hand" onclick="ln_Query()" />
								<img src="<%=dirPath%>/Sales/images/plus.gif" style="cursor: hand" onclick="ln_Add('01')" />	
                				<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor: hand" onclick="ln_Delete('01')" />		
                				<img src="<%=dirPath%>/Sales/images/save.gif" style="cursor: hand" onclick="ln_Save('01')" />
								<img src="<%=dirPath%>/Sales/images/print.gif" style="cursor: hand" onclick="ln_Print()" />
								<img src="<%=dirPath%>/Sales/images/excel.gif" style="cursor: hand" onclick="ln_Excel('01')" />
							</td>
					</tr>																		
		</tbody></table>
		</td><!-- 버튼 영역 끝-->
	</tr>
	<tr>
<!-- 좌칙 그리드 영역 시작-->
	<td align="left" width="175px" height="494" valign="top">
		<table height="0" border="0" cellpadding="0" cellspacing="1" >
						<!-- <tr height="35px"> -->
						<tbody><tr height="40">
							<td width="px" align="center" bgcolor="#eeeeee" style="width: 80px" cellpadding="1">재직<br />구분</td>
							<td width="" bgcolor="#FFFFFF">
								<%=HDConstant.COMMENT_START%><object id="gclx_usts" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 100px">
									<param name="CBData" value="^전체,1^재직^,3^퇴직" />
									<param name="CBDataColumns" value="COM_CODE,COM_SNAME" />
									<param name="Index" value="1" />
									<param name="SearchColumn" value="COM_SNAME" />
									<param name="ListExprFormat" value="COM_SNAME^0^70" />								
									<param name="BindColumn" value="COM_CODE" />
									<param name="Enable" value="true" />
								</object><%=HDConstant.COMMENT_END%>
								<!-- <input type=text id="txt_nm" class="txt_a01" style="width:80px;top:0px;" maxlength=30> -->
								</td>
						</tr>
						<tr height="40">
							<td align="center" bgcolor="#eeeeee">소속<br />구분</td>
							<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%><object id="gclx_cmsosok" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 100px">
														<param name="ComboDataID" value="gcds_cmsosok" />
														<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
														<param name="SearchColumn" value="COM_SNAME" />
														<param name="Sort" value="false" />
														<param name="Index" value="0" />
														<param name="ListExprFormat" value="COM_SNAME^0^100" />
														<param name="BindColumn" value="COM_CODE" />
												</object><%=HDConstant.COMMENT_END%>
								<!-- <input type=text id="txt_dept" class="txt_a01" style="width:80px;top:0px;" maxlength=30> -->
							</td>
						</tr>
						<tr height="40">
							<td align="center" bgcolor="#eeeeee">성명</td>
							<td bgcolor="#FFFFFF">
								<input type="text" id="txt_nm" class="" style="position: relative; left: 5px; width: 100px; top: 0px" maxlength="30" onkeydown="if(event.keyCode==13)ln_Query();" />
								<input type="hidden" id="txt_usts" style="width: 80px; top: 0px" maxlength="1" />
							</td>
						</tr>
						<tr>
							<td colspan="2" class="" bgcolor="#FFFFFF">
								<%=HDConstant.COMMENT_START%>
									<object id="gcgd_disp" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="height: 327; width: 170">
										<param name="DataID" value="gcds_data00" />
										<param name="BorderStyle" value="0" /> 
										<param name="indwidth" value="0" />
										<param name="fillarea" value="true" />
										<param name="Colsizing" value="true" />
										<param name="Editable" value="false" />
										<param name="headlinecolor" value="#999999" />
										<param name="sortview" value="left" />
										<param name="format" value='
											<FC>ID=EMPNO    	Name="직번",  width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , sort = true ,align="left"</FC>
											<FC>ID=EMPNMK    	Name="성명",  width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , sort = true ,align="left"</FC>
											<C>ID=JOB_CD    		Name="직종",  width=60,	   HeadBgColor=#B9D4DC,	HeadAlign=center , sort = true,EditStyle=Lookup,Data="gcds_cm004:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=VEND_CD   	Name="근무업체", width=70, HeadBgColor=#B9D4DC,	HeadAlign=center , sort = false,EditStyle=Lookup,Data="gcds_cm019:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=DEPT_CD   	Name="부서",  width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , EditStyle=Lookup,Data="gcds_cm006:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=TEAM_CD   	Name="소속",  width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , EditStyle=Lookup,Data="gcds_cm003:COM_CODE:COM_SNAME" ,align="left"</C>
											<C>ID=WORK_CD   	Name="근무지",width=50,	   HeadBgColor=#B9D4DC,	HeadAlign=center , EditStyle=Lookup,Data="gcds_cm007:COM_CODE:COM_SNAME" ,align="left"</C>
										' />
								</object><%=HDConstant.COMMENT_END%>
								<fieldset bgcolor="#FFFFFF" style="width: 170; height: 20px; border: 0 solid #708090; border-top-width: 1px; text-align: left; bgcolor: #ffffff">
									&nbsp;<font id="ft_cnt1" style="position:relative;top:4px;">
								</font></fieldset>
							</td>
					</tr>
		</tbody></table>
	</td>
<!-- 좌칙 그리드 영역 끝-->
	<td width="10"></td><!-- 중간 여백부분 -->
	<td width="649" valign="top"><!-- 우측 테이블 상단 시작-->
		<table width="649" height="473" border="0" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td width="125" valign="top">
					<table width="125" height="159" border="1" cellpadding="0" cellspacing="1">
						<tbody><tr>
							<td align="center" bgcolor="#FFFFFF">
								<img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" border="0" width="100px" height="131px" style="position: relative; top: 2px" />
								<!-- <img id="photo" src="worker/9080001.jpg" border=0 width="100px" height="124px" style="position:relative;top:2px;"> -->
							</td>
							</tr>
							<tr>
								<td align="center" bgcolor="#FFFFFF" height="22">&nbsp;
								<!-- 	<input type="hidden" id=txt_file name="txt_file" readonly style="position:relative;left:6px;width:100px">
									<%=HDConstant.COMMENT_START%><OBJECT id=gcip_file classid=CLSID:69F1348F-3EBE-11D3-973D-0060979E2A03
									style="position:relative;left:0px;top:0px;width:80; height:25;">
									<param name="Text"		value="찾아보기">
									<param name="Enable"  value="true">
									</OBJECT><%=HDConstant.COMMENT_END%> -->
								</td>
							</tr>
							<tr>
								<td align="center" bgcolor="#FFFFFF" height="22">&nbsp;
								</td>
							</tr>
						</tbody></table>
				</td>
				<td width="524" align="left" valign="top">
						<table width="539" cellpadding="0" cellspacing="1"
							bgcolor="#708090" border="0">
							<tbody>
								<tr height="23">
									<td width="80" bgcolor="#eeeeee">&nbsp;성명</td>
									<td bgcolor="#FFFFFF" width="171"><%=HDConstant.COMMENT_START%><object
										id="gcem_empnmk"
										classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
										tabindex="1"
										style="position: relative; left: 8px; top: 1px; width: 80px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="0" />
										<param name="Border" value="true" />
										<param name="Format" value="###############" />
										<param name="GeneralEdit" value="true" />
									</object><%=HDConstant.COMMENT_END%></td>
									<td bgcolor="#FFFFFF" width="93"></td>
									<td bgcolor="#FFFFFF" width="170"></td>
									<!-- </form> -->
								</tr>

								<tr height="22">
									<td width="80" bgcolor="#eeeeee">&nbsp;직번</td>
									<td bgcolor="#FFFFFF" width="171"><input type="text"
										id="txt_empno" class="txt_a01"
										style="position: relative; left: 8px; width: 75px; background-color: #ccffcc"
										readonly="readonly" /> <!-- <input type="hidden" id=txt_custid class="txt_a01" style="width:80px;" > -->
									</td>
									<td bgcolor="#eeeeee" width="93">&nbsp;생년월일</td>
									<td bgcolor="#FFFFFF" width="170"><%=HDConstant.COMMENT_START%><object
										id="gcem_birthday"
										classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
										tabindex="1"
										style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="0" />
										<param name="Border" value="true" />
										<param name="Format" value="YYYY/MM/DD" />
										<param name="PromptChar" value="_" />
										<param name="ReadOnly" value="true" />
										<param name="ReadOnlyBackColor" value="#CCFFCC" />
									</object><%=HDConstant.COMMENT_END%></td>
								</tr>
								<tr height="22">
									
									<td bgcolor="#eeeeee">&nbsp;성별</td>
									<td bgcolor="#FFFFFF" width="171"><%=HDConstant.COMMENT_START%><object
										id="gcra_sex"
										classid="CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0"
										style="position: relative; left: 0px; top: 0px; height: 20; width: 80; cursor: hand">
										<param name="Cols" value="2" />
										<param name="Format" value="M^남,F^여" />
									</object><%=HDConstant.COMMENT_END%></td>
									
									<td bgcolor="#eeeeee" width="93">&nbsp;입사구분</td>
									<td bgcolor="#FFFFFF" width="170"><%=HDConstant.COMMENT_START%><object
										id="gclx_ord_cd"
										classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69"
										style="position: relative; left: 8px; top: 1px; font-size: 12px; width: 80px">
										<param name="ComboDataID" value="gcds_cm024" />
										<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
										<param name="SearchColumn" value="COM_SNAME" />
										<param name="Sort" value="false" />
										<param name="Enable" value="false" />
										<param name="ListExprFormat" value="COM_SNAME^0^100" />
										<param name="BindColumn" value="COM_CODE" />
									</object><%=HDConstant.COMMENT_END%></td>
								</tr>
								
								<tr height="22">
									
									<td bgcolor="#eeeeee">&nbsp;입직일</td>
									<td bgcolor="#FFFFFF" width="171"><%=HDConstant.COMMENT_START%><object
										id="gcem_start_dt"
										classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
										tabindex="1"
										style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="0" />
										<param name="Border" value="true" />
										<param name="Format" value="YYYY/MM/DD" />
										<param name="PromptChar" value="_" />
										<param name="ReadOnlyBackColor" value="#CCFFCC" />
									</object><%=HDConstant.COMMENT_END%></td>
									
									<td bgcolor="#eeeeee" width="93">&nbsp;퇴직일</td>
									<td bgcolor="#FFFFFF" width="170"><%=HDConstant.COMMENT_START%>
									<object
										id="gcem_end_dt"
										classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
										tabindex="1"
										style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="0" />
										<param name="Border" value="true" />
										<param name="Format" value="YYYY/MM/DD" />
										<param name="PromptChar" value="_" />
										<param name="ReadOnly" value="true" />
										<param name="ReadOnlyBackColor" value="#CCFFCC" />
									</object><%=HDConstant.COMMENT_END%></td>
								</tr>
																
								<tr height="22">
									
									<td  bgcolor="#eeeeee">&nbsp;근무업체</td>
									<td  bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT><%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
									</td>
									
									<td bgcolor="#eeeeee" width="93">&nbsp;부서</td>
									<td  bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT><%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
									</td>
								</tr>

								<tr height="22">
									
									<td bgcolor="#eeeeee">&nbsp;소속팀</td>
									<td bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT><%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
									</td>

									<td bgcolor="#eeeeee" width="93">&nbsp;근무현장</td>
									<td bgcolor="#FFFFFF">
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT><%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
									</td>
								</tr>

								<tr height="22">
									
									<td bgcolor="#eeeeee">&nbsp;직종</td>
									<td bgcolor="#FFFFFF">
										
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT><%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
									</td>
									
									<td bgcolor="#eeeeee" width="93">&nbsp;기능구분</td>
									<td bgcolor="#FFFFFF">
										
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT><%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
									</td>
								</tr>

								<tr height="22">

									<td bgcolor="#eeeeee">&nbsp;비용부담업체</td>
									<td bgcolor="#FFFFFF">
										
										<fieldset class=field_01 style="width:100px;  height: 18px;position:relative; left:2px;  top:1px;">
										<%=HDConstant.COMMENT_START%><OBJECT id=gcem_team_nm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											class="gcem_01" style="width:90px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border	      value=false>
												<param name=Format	      value="">
												<param name=PromptChar	  value="">
												<param name=UpperFlag     value=1>
												<param name=GeneralEdit   value="true">
												<param name=Enable        value="false">
										</OBJECT><%=HDConstant.COMMENT_END%>
										</fieldset>											
									 <img src="<%=dirPath%>/Sales/images/help.gif" border="0" style="cursor:hand;position:relative;left:1px;top:1px;" onclick="ln_SrhCust();">
									</td>									
									
									<td bgcolor="#eeeeee" width="93">&nbsp;근속년차</td>
									<td bgcolor="#FFFFFF" width="170"><%=HDConstant.COMMENT_START%>
									<object id="gcem_con_year" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" tabindex="1"
										style="position: relative; left: 8px; top: 1px; width: 50px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="2" />
										<param name="ReadOnly" value="true" />
										<param name="ReadOnlyBackColor" value="#CCFFCC" />
										<param name="Border" value="true" />
										<param name="MaxLength" value="2" />
										<param name="PromptChar" value="_" />
									</object><%=HDConstant.COMMENT_END%></td>
								</tr>
								<tr height="22">
									
									<td bgcolor="#eeeeee">&nbsp;급여변경일</td>
									<td bgcolor="#FFFFFF" width="171"><%=HDConstant.COMMENT_START%><object
										id="gcem_chgymd"
										classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
										tabindex="1"
										style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
										<param name="Alignment" value="0" />
										<param name="Border" value="true" />
										<param name="Format" value="YYYY/MM/DD" />
										<param name="PromptChar" value="_" />
										<param name="ReadOnly" value="true" />
										<param name="ReadOnlyBackColor" value="#CCFFCC" />
									</object><%=HDConstant.COMMENT_END%></td>

									<td bgcolor="#eeeeee">&nbsp;알선료 </td>
									<td bgcolor="#FFFFFF" width="171"><%=HDConstant.COMMENT_START%>
									<object id="gcra_recomm"	classid="CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0"
										style="position: relative; left: 0px; top: 0px; height: 20; width: 120; cursor: hand">
										<param name="Cols" value="2" />
										<param name="Format" value="Y^지급,N^미지급" />
									</object><%=HDConstant.COMMENT_END%></td>

								</tr>
							</tbody>
						</table>
						</td>
			</tr>
			<tr height="1"><td colspan="3"></td></tr>

			<tr height="20">
				<td colspan="3" valign="top">
					<%=HDConstant.COMMENT_START%><object id="gcte_disp" classid="clsid:ED382953-E907-11D3-B694-006097AD7252" style="width: 650px; height: 20px">
					<param name="BackColor" value="#cccccc" />
					<param name="titleHeight" value="20px" />
					<param name="DisableBackColor" value="#eeeeee" />
					<param name="Format" value="
					<T>divid=layer1  title='기본'</T>									
					<T>divid=layer2  title='사내경력'</T>
					<T>divid=layer3  title='휴가'</T>

					" />
					</object><%=HDConstant.COMMENT_END%>
				</td>
			</tr>

			<tr height="230">
				<td>
<!---------[TAB 1] left:200px;기본사항 ----------->
						<div id="layer1" style="position: absolute; top: 360px; left: 350px">
							<table style="position: relative; top: 4px; border: 0 solid #708090; border-bottom-width: 0px" cellpadding="0" cellspacing="0" border="0">
								<!-- 주소부분 -->
                 <tbody><tr> 
										<td>
											 <table style="position: relative; top: 0px; border: 1 solid #708090; border-bottom-width: 0px" style="width:648px;" cellpadding="0" cellspacing="0" border="0">
													<tbody>
													<tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" rowspan="2">주 소</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">현주소</td>
														<td class="tab22" width="512px" colspan="5">
															<input type="text" id="txt_chi_add" class="txt11" style="position: relative; left: 8px; width: 250px" maxlength="40" />
														 </td>
													</tr>



											 </tbody></table>
										</td>
								 </tr>
								  <tr> 
										<td>
											 <table style="position: relative; top: 0px; border: 0 solid #708090; border-left-width: 1px; border-right-width: 1px" style="width:648px;" cellpadding="0" cellspacing="0" border="0">
													<tbody><tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" rowspan="2">신체사항</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">신장</td>
														<td class="tab22" width="111px">
															<%=HDConstant.COMMENT_START%>
																<object id="gcem_height" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
																	<param name="Text" value="0" />
																	<param name="Alignment" value="2" />
																	<param name="Border" value="true" />
																	<param name="MaxLength" value="3" />
																	<param name="MaxDecimalPlace" value="1" />
																	<param name="PromptChar" value="_" />
																	<param name="SelectAll" value="true" />
																</object>
														 <%=HDConstant.COMMENT_END%>
														 &nbsp; (cm)
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align="center">체중</td>
														<td class="tab22" width="113px">
															<%=HDConstant.COMMENT_START%>
																<object id="gcem_weight" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
																	<param name="Text" value="0" />
																	<param name="Alignment" value="2" />
																	<param name="Border" value="true" />
																	<param name="MaxLength" value="3" />
																	<param name="MaxDecimalPlace" value="1" />
																	<param name="PromptChar" value="_" />
																	<param name="SelectAll" value="true" />
																</object>
														 <%=HDConstant.COMMENT_END%>
														 &nbsp; (kg)
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align="center">혈액형</td>
														<td class="tab22" width="165px">
															<%=HDConstant.COMMENT_START%>
																<object id="gcem_blood" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" style="position: relative; left: 8px; top: 1px; width: 30px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
																	<param name="Alignment" value="0" />
																	<param name="Border" value="true" />
																	<param name="format" value="AA" />
																	<param name="UpperFlag" value="1" />
																</object>
														 <%=HDConstant.COMMENT_END%>
														</td>
													</tr>

											 </tbody></table>
										</td>
								 </tr>
								 <tr> 
										<td>
											 <table style="position: relative; top: 0px; border: 0 solid #708090; border-left-width: 1px; border-right-width: 1px" style="width:648px;" cellpadding="0" cellspacing="0" border="0">
													<tbody><tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" rowspan="2">학력사항</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">최종학력</td>
														<td class="tab22"  width="111px">
															<%=HDConstant.COMMENT_START%>
																<object id="gclx_att_cd" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 8px; top: 1px; font-size: 12px; width: 80px">
																	<param name="ComboDataID" value="gcds_cm027" />
																	<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
																	<param name="SearchColumn" value="COM_SNAME" />
																	<param name="Sort" value="false" />
																	<param name="ListExprFormat" value="COM_SNAME^0^100" />
																	<param name="BindColumn" value="COM_CODE" />
															 </object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align="center" >학교명</td>
														<td class="tab22" width="340px" colspan="3">
															<input type="text" id="txt_sch_nm" class="txt11" style="position: relative; left: 8px; width: 80px" maxlength="20" />
														</td>
													</tr>
											 </tbody></table>
										</td>
								 </tr>
								 
								 <tr> 
										<td>
											 <table style="position: relative; top: 0px; border: 0 solid #708090; border-left-width: 1px; border-right-width: 1px" style="width:648px;" cellpadding="0" cellspacing="0" border="0">
													<tbody><tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" rowspan="2">가족사항</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee">가족수</td>
														<td class="tab22" width="111px">
															<%=HDConstant.COMMENT_START%>
																<object id="gcem_family" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" style="position: relative; left: 8px; top: 1px; width: 70px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
																	<param name="Text" value="0" />
																	<param name="Alignment" value="2" />
																	<param name="Border" value="true" />
																	<param name="MaxLength" value="3" />
																	<param name="MaxDecimalPlace" value="1" />
																	<param name="PromptChar" value="_" />
																	<param name="SelectAll" value="true" />
																</object>
														 <%=HDConstant.COMMENT_END%>
														 &nbsp; (명)
														</td>
														<td class="tab17" width="60px" bgcolor="#eeeeee" align="center">결혼</td>
														<td class="tab22" width="340px" bgcolor="#FFFFFF" colspan="3"><%=HDConstant.COMMENT_START%><object
															id="gcra_wedding"
															classid="CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0"
															style="position: relative; left: 0px; top: 0px; height: 20; width: 100; cursor: hand">
															<param name="Cols" value="2" />
															<param name="Format" value="N^미혼,Y^기혼" />
														</object><%=HDConstant.COMMENT_END%></td>
													</tr>
											 </tbody></table>
										</td>
								 </tr>								 
								 
								 
								 <tr> 
										<td>
											 <table style="position: relative; top: 0px; border: 0 solid #708090; border-left-width: 1px; border-right-width: 1px" style="width:648px;" cellpadding="0" cellspacing="0" border="0">
													<tbody><tr>
														<td class="tab11" width="80px" bgcolor="#eeeeee" rowspan="2">기타사항</td>
														<td class="tab11" width="60px" bgcolor="#eeeeee" align="center">기본급</td>
														<td class="tab22" width="512px" colspan="5">
															<%=HDConstant.COMMENT_START%><object id="gcem_b_pay" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F" tabindex="1" style="position: relative; left: 8px; top: 3px; width: 50px; height: 20px; font-family: 굴림; font-size: 9pt; z-index: 2">
																	<param name="Alignment" value="2" />
																	<param name="Border" value="true" />
																	<param name="MaxLength" value="3" />
																	<param name="MaxDecimalPlace" value="1" />
																	<param name="PromptChar" value="_" />
																	<param name="ReadOnly" value="true" />
														      <param name="ReadOnlyBackColor" value="#CCFFCC" />
															</object><%=HDConstant.COMMENT_END%>&nbsp; <font style="position:relative;top:-3px;">(현재기본급)
														    <input type="hidden" id="txt_tel_no" class="txt11" style="width: 80px" maxlength="20" />
														    <input type="hidden" id="txt_mobile_no" class="txt11" style="width: 80px" maxlength="20" />
														</font></td>

													</tr>
											 </tbody></table>
										</td>
								 </tr>
							</tbody></table>
						</div>
						<!---------[TAB 2] 사내경력 그리드----------->
						<div id="layer2" style="position: absolute; top: 364px; left: 350px; visibility: hidden; border: 1 solid #708090">
							<table cellpadding="0" cellspacing="0" border="0">
								<tbody><tr>
									<td height="25px" align="right" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/refer.gif" style="position: relative; top: 2px; cursor: hand" onclick="ln_OrdQuery()" />
									  <img name="btn_del_3" src="<%=dirPath%>/Sales/images/delete.gif" style="position: relative; top: 2px; cursor: hand" onclick="ln_Delete('02')" />
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width: 639; border: 0 solid #708090; border-top-width: 1px" colspan="2">
										<%=HDConstant.COMMENT_START%><object id="gcgd_disp02" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width: 647; height: 179">
												<param name="dataid" value="gcds_data02" />
												<param name="BorderStyle" value="0" /> 
												<param name="indwidth" value="0" />
												<param name="fillarea" value="true" />
												<param name="headlinecolor" value="#999999" />
												<param name="format" value='
													<F> Name=NO				ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=center </F> 
													<F> Name=발령일자	ID=ORD_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80,	 align=center, MASK="XXXX/XX/XX"</F> 
													<C> Name=발령구분 ID=ORD_CD,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80,   EditStyle=Lookup,Data="gcds_cm012:COM_CODE:COM_SNAME" ,align="left"</C> 
													<C> Name=근무업체 ID=VEND_CD,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80,   EditStyle=Lookup,Data="gcds_cm019:COM_CODE:COM_SNAME" ,align="left"</C> 
													<C> Name=소속팀		ID=TEAM_CD, HeadAlign=Center HeadBgColor=#B9D4DC Width=80,   EditStyle=Lookup,Data="gcds_cm003:COM_CODE:COM_SNAME" ,align="left"</C> 
													<C> Name=근무지		ID=WORK_CD, HeadAlign=Center HeadBgColor=#B9D4DC Width=80,   EditStyle=Lookup,Data="gcds_cm007:COM_CODE:COM_SNAME" ,align="left"</C> 
													<C> Name=직종			ID=JOB_CD,  HeadAlign=Center HeadBgColor=#B9D4DC Width=60,   EditStyle=Lookup,Data="gcds_cm004:COM_CODE:COM_SNAME" ,align="left"</C>
													<C> Name=비고			ID=REMARK,  HeadAlign=Center HeadBgColor=#B9D4DC Width=140, ,align="left"</C>
													' />
										</object><%=HDConstant.COMMENT_END%>
										<fieldset style="width: 639; height: 20px; border: 0 solid #708090; border-top-width: 1px; text-align: left">
											&nbsp;<font id="ft_cnt2" style="position:relative;top:4px;">
										</font></fieldset>
									</td>
								</tr>
							</tbody></table>
						</div>


						<!---------[TAB 3] 휴가 그리드----------->
						<div id="layer3" style="position: absolute; top: 364px; left: 350px; visibility: hidden; border: 1 solid #708090">
							<table cellpadding="0" cellspacing="0" border="0">
								<tbody><tr>
									<td height="25px" align="right" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<img name="btn_del_3" src="<%=dirPath%>/Sales/images/refer.gif" style="position: relative; top: 2px; cursor: hand" onclick="ln_VacQuery()" />
									</td>
									<td width="4px;"></td>
								</tr> 
								<tr>
									<td style="width: 639; border: 0 solid #708090; border-top-width: 1px" colspan="2">
										<%=HDConstant.COMMENT_START%><object id="gcgd_disp06" classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width: 647; height: 179">
												<param name="dataid" value="gcds_data06" />
												<param name="BorderStyle" value="0" /> 
												<param name="indwidth" value="0" />
												<param name="fillarea" value="true" />
												<param name="Editable" value="false" />
												<param name="AllShowEdit" value="true" />
												<param name="Colsizing" value="true" />
												<param name="headlinecolor" value="#999999" />
												<param name="format" value='
												<F> Name=NO			    	 ID={CurRow} HeadAlign=Center HeadBgColor=#B9D4DC Width=30, align=center</F>
												<C> Name=소속		       ID=TEAM_NM,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center </C>
												<C> Name=휴가시작일		 ID=START_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=center Mask="XXXX/XX/XX"</C>
												<C> Name=휴가종료일		 ID=END_DT,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=center Mask="XXXX/XX/XX"</C>
												<C> Name=휴가일수			 ID=H_DAY,	HeadAlign=Center HeadBgColor=#B9D4DC Width=80   align=right </C>
												<C> Name=휴가사유			 ID=H_RES,	HeadAlign=Center HeadBgColor=#B9D4DC Width=280  align=left  </C>
												' />
										</object><%=HDConstant.COMMENT_END%>
										<fieldset style="width: 639; height: 20px; border: 0 solid #708090; border-top-width: 1px; text-align: left">
											&nbsp;<font id="ft_cnt6" style="position:relative;top:4px;">
										</font></fieldset>
									</td>
								</tr>
							</tbody></table>
						</div>



<!-- 데이타바인드 정의부분 -->
						<%=HDConstant.COMMENT_START%><object id="gcbn_data00" classid="clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49">
						<param name="DataID" value="gcds_data00" />
						<param name="ActiveBind" value="true" />
						<param name="BindInfo" value="
								<C>Col=USTS           			Ctrl=txt_usts								Param=value</C>
								<C>Col=EMPNMK           		Ctrl=gcem_empnmk						Param=Text</C>
								<C>Col=EMPNMC           		Ctrl=gcem_empnmc						Param=Text</C>
								<C>Col=ENG_NM          			Ctrl=gcem_eng_nm						Param=Text</C>
								<C>Col=EMPNO            		Ctrl=txt_empno							Param=value</C>
								<C>Col=BIRTHDAY         		Ctrl=gcem_birthday					Param=Text</C>
								<C>Col=SEX              		Ctrl=gcra_sex								Param=codevalue</C>
								<C>Col=NATION_CD        		Ctrl=gclx_nation_cd					Param=bindcolval</C>
								<C>Col=START_DT         		Ctrl=gcem_start_dt					Param=Text</C>
								<C>Col=JOB_CD           		Ctrl=gclx_job_cd						Param=bindcolval</C>
								<C>Col=AGENCY_CD        		Ctrl=gclx_agency_cd					Param=bindcolval</C>
								<C>Col=VEND_CD          		Ctrl=gclx_vend_cd						Param=bindcolval</C>
								<C>Col=DEPT_CD          		Ctrl=gclx_dept_cd						Param=bindcolval</C>
								<C>Col=TEAM_CD          		Ctrl=gclx_team_cd						Param=bindcolval</C>
								<C>Col=WORK_CD          		Ctrl=gclx_work_cd						Param=bindcolval</C>
								<C>Col=SKILL_CD         		Ctrl=gclx_skill_cd					Param=bindcolval</C>
								<C>Col=COUNTRY_CD       		Ctrl=gclx_country_cd				Param=bindcolval</C>
								<C>Col=CON_YEAR         		Ctrl=gcem_con_year					Param=Text</C>
								<C>Col=CUST_SID        			Ctrl=gcem_cust_sid 					Param=Text</C>
								<C>Col=BIRTHDAY        			Ctrl=gcem_birthday 					Param=Text</C>
								<C>Col=PASS_NO         			Ctrl=gcem_pass_no 					Param=Text</C>
								<C>Col=PASS_EXPIRE_DATE			Ctrl=gcem_pass_epdate 			Param=Text</C>
								<C>Col=N_CARD_NO       			Ctrl=gcem_n_card_no 				Param=Text</C>
								<C>Col=ZIP_CD								Ctrl=txt_zipcd		 					Param=Value</C>
								<C>Col=ADDRESS1							Ctrl=txt_address1 					Param=Value</C>
								<C>Col=TEL_NO								Ctrl=txt_tel_no   					Param=Value</C>
								<C>Col=MOBILE_NO						Ctrl=txt_mobile_no					Param=Value</C>
								<C>Col=HEIGHT								Ctrl=gcem_height   					Param=text</C>
								<C>Col=WEIGHT								Ctrl=gcem_weight   					Param=text</C>
								<C>Col=SIZE_UP							Ctrl=txt_size_up  					Param=Value</C>
								<C>Col=SIZE_DN							Ctrl=txt_size_dn  					Param=Value</C>
								<C>Col=SIZE_FT							Ctrl=gcem_size_ft  					Param=text</C>
								<C>Col=SIZE_WT							Ctrl=gcem_size_wt  					Param=text</C>
								<C>Col=BLOOD								Ctrl=gcem_blood    					Param=text</C>
								<C>Col=ORD_CD								Ctrl=gclx_ord_cd    				Param=bindcolval</C>
								<C>Col=END_DT								Ctrl=gcem_end_dt  				  Param=text</C>
								<C>Col=CHGYMD								Ctrl=gcem_chgymd    				Param=text</C>
								<C>Col=C_VEND_CD						Ctrl=gclx_c_vend_cd   			Param=bindcolval</C>
								<C>Col=CHI_NM								Ctrl=txt_chi_nm    				  Param=value</C>
								<C>Col=CHI_RNM							Ctrl=txt_chi_rnm    				Param=value</C>
								<C>Col=CHI_TEL							Ctrl=txt_chi_tel    				Param=value</C>
								<C>Col=CHI_ADD							Ctrl=txt_chi_add    			  Param=value</C>
								<C>Col=SCH_FR								Ctrl=gcem_sch_fr    				Param=text</C>
								<C>Col=SCH_TO								Ctrl=gcem_sch_to    				Param=text</C>
								<C>Col=ATT_CD								Ctrl=gclx_att_cd    				Param=bindcolval</C>
								<C>Col=SCH_NM								Ctrl=txt_sch_nm    				  Param=value</C>
								<C>Col=HOBBY								Ctrl=txt_hobby   				    Param=value</C>
								<C>Col=SPC_NM								Ctrl=txt_spc_nm   				  Param=value</C>
								<C>Col=B_PAY								Ctrl=gcem_b_pay    				  Param=text</C>
								<C>Col=PICTURE							Ctrl=gcip_file    				  Param=value</C>
								<C>Col=REM_BNK							Ctrl=gclx_rem_bnk 				  Param=bindcolval</C>
								<C>Col=SAV_NM								Ctrl=txt_sav_nm   				  Param=value</C>
								<C>Col=SAV_TEL							Ctrl=txt_sav_tel   				  Param=value</C>
								<C>Col=REM_ACC							Ctrl=txt_rem_acc   				  Param=value</C>
							" />
						</object><%=HDConstant.COMMENT_END%>

<!-- 기본탭 -->
					<!-- 	<%=HDConstant.COMMENT_START%><OBJECT id=gcbn_data12 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 >
							<PARAM NAME="DataID"				VALUE="gcds_data12">
							<PARAM NAME="ActiveBind"		VALUE="true">
							<PARAM NAME="BindInfo"			VALUE="
							<C>Col=ZIP_ADD 				Ctrl=txt_address1 					Param=Value</C>
							
							<C>Col=TEL_NO   			Ctrl=txt_tel_no   					Param=Value</C>
							<C>Col=MOBILE_NO			Ctrl=txt_mobile_no					Param=Value</C>
							<C>Col=HEIGHT   			Ctrl=gcem_height   					Param=text</C>
							<C>Col=WEIGHT   			Ctrl=gcem_weight   					Param=text</C>
							<C>Col=SIZE_UP  			Ctrl=txt_size_up  					Param=Value</C>
							<C>Col=SIZE_DN  			Ctrl=txt_size_dn  					Param=Value</C>
							<C>Col=SIZE_FT  			Ctrl=gcem_size_ft  					Param=text</C>
							<C>Col=SIZE_WT  			Ctrl=gcem_size_wt  					Param=text</C>
							<C>Col=BLOOD    			Ctrl=gcem_blood    					Param=text</C>
							">
						</OBJECT><%=HDConstant.COMMENT_END%> -->
				</td>
			</tr>
	</tbody></table><!-- 우측 테이블 상단 끝-->
</td>
</tr>
</tbody></table>

<%=HDConstant.COMMENT_START%><object id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F">
	<param name="MasterDataID" value="gcds_report0" />
	<param name="PaperSize" value="A4" />	
	<param name="LandScape" value="0" />
  <param name="PrintSetupDlgFlag" value="true" />
	<param name="PreviewZoom" value="100" />
	<param name="Format" value="
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=992 ,face='굴림' ,size=10 ,penwidth=1
	<X>left=389 ,top=931 ,right=1934 ,bottom=992 ,border=true</X>
	<X>left=106 ,top=550 ,right=201 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=198 ,top=550 ,right=392 ,bottom=614 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=198 ,top=614 ,right=392 ,bottom=741 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=198 ,top=741 ,right=392 ,bottom=868 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=198 ,top=868 ,right=392 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=868 ,right=1934 ,bottom=931 ,border=true</X>
	<X>left=929 ,top=931 ,right=1114 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=931 ,right=574 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=868 ,right=574 ,bottom=931 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=804 ,right=1934 ,bottom=868 ,border=true</X>
	<X>left=389 ,top=741 ,right=1934 ,bottom=804 ,border=true</X>
	<X>left=929 ,top=741 ,right=1114 ,bottom=804 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=741 ,right=574 ,bottom=804 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=804 ,right=574 ,bottom=868 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=677 ,right=1934 ,bottom=741 ,border=true</X>
	<X>left=389 ,top=677 ,right=574 ,bottom=741 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=614 ,right=1934 ,bottom=677 ,border=true</X>
	<X>left=574 ,top=206 ,right=1934 ,bottom=273 ,border=true</X>
	<X>left=389 ,top=550 ,right=1934 ,bottom=614 ,border=true</X>
	<X>left=108 ,top=206 ,right=389 ,bottom=540 ,border=true</X>
	<X>left=574 ,top=474 ,right=1934 ,bottom=540 ,border=true</X>
	<X>left=923 ,top=474 ,right=1109 ,bottom=540 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=574 ,top=273 ,right=1934 ,bottom=341 ,border=true</X>
	<X>left=923 ,top=273 ,right=1109 ,bottom=341 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=574 ,top=341 ,right=1934 ,bottom=407 ,border=true</X>
	<X>left=1450 ,top=206 ,right=1635 ,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='사  번' ,left=1455 ,top=212 ,right=1630 ,bottom=267 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='근로자 관리 정보' ,left=108 ,top=19 ,right=1934 ,bottom=122 ,face='HY견고딕' ,size=18 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=389 ,top=206 ,right=574 ,bottom=273 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='성  명' ,left=394 ,top=212 ,right=569 ,bottom=267 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=389 ,top=273 ,right=574 ,bottom=341 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='여권번호' ,left=394 ,top=275 ,right=569 ,bottom=331 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=389 ,top=341 ,right=574 ,bottom=407 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=574 ,top=407 ,right=1934 ,bottom=474 ,border=true</X>
	<X>left=389 ,top=407 ,right=574 ,bottom=474 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=389 ,top=474 ,right=574 ,bottom=540 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='EMPNMK', left=585, top=212, right=794, bottom=267, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EMPNO', left=1640, top=212, right=1868, bottom=267, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='생년월일' ,left=929 ,top=280 ,right=1103 ,bottom=336 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=273 ,right=1635 ,bottom=341 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='성  별' ,left=1455 ,top=278 ,right=1630 ,bottom=333 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='여권만료일' ,left=394 ,top=347 ,right=569 ,bottom=402 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=923 ,top=341 ,right=1109 ,bottom=407 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='입사일' ,left=929 ,top=347 ,right=1103 ,bottom=402 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=341 ,right=1635 ,bottom=407 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='퇴사일' ,left=1455 ,top=347 ,right=1630 ,bottom=402 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='소  속' ,left=394 ,top=413 ,right=569 ,bottom=468 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=923 ,top=407 ,right=1109 ,bottom=474 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='직  종' ,left=929 ,top=413 ,right=1103 ,bottom=468 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=407 ,right=1635 ,bottom=474 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='송출대리점' ,left=1455 ,top=413 ,right=1630 ,bottom=468 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='입사구분' ,left=394 ,top=476 ,right=569 ,bottom=532 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='국  적' ,left=929 ,top=476 ,right=1103 ,bottom=532 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1450 ,top=474 ,right=1635 ,bottom=540 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='민  족' ,left=1455 ,top=476 ,right=1630 ,bottom=532 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='정보' ,left=111 ,top=736 ,right=196 ,bottom=794 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='기본' ,left=111 ,top=691 ,right=196 ,bottom=746 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=389 ,top=550 ,right=574 ,bottom=614 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<I>id='PIC_DIR' ,left=111 ,top=209 ,right=389 ,bottom=540</I>
	<T>id='주  소' ,left=405 ,top=556 ,right=553 ,bottom=609 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='EMPNMC', left=796, top=212, right=1005, bottom=267, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PASS_NO', left=585, top=280, right=905, bottom=336, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ORD_NM', left=585, top=479, right=905, bottom=534, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PASS_EXPIRE_DATE', left=585, top=347, right=905, bottom=402, align='left' ,mask='XXXX년XX월XX일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TEAM_NM', left=585, top=413, right=905, bottom=468, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BIRTHDAY', left=1117, top=280, right=1437, bottom=336, align='left' ,mask='XXXX년XX월XX일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SEX_NM', left=1640, top=280, right=1926, bottom=336, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='START_DT', left=1117, top=347, right=1437, bottom=402, align='left' ,mask='XXXX년XX월XX일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='END_DT', left=1640, top=347, right=1926, bottom=402, align='left' ,mask='XXXX년XX월XX일', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JOB_NM', left=1117, top=413, right=1437, bottom=468, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='AGENCY_NM', left=1640, top=413, right=1926, bottom=468, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='COUNTRY_NM', left=1117, top=479, right=1437, bottom=534, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='NATION_NM', left=1640, top=479, right=1926, bottom=534, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ADDRESS1', left=582, top=556, right=1918, bottom=611, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='입출국증' ,left=212 ,top=556 ,right=378 ,bottom=611 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='CHI_ADD', left=582, top=616, right=1918, bottom=672, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=389 ,top=614 ,right=574 ,bottom=677 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='주  소' ,left=405 ,top=616 ,right=553 ,bottom=669 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='성  명' ,left=405 ,top=680 ,right=553 ,bottom=733 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='중국내' ,left=225 ,top=627 ,right=355 ,bottom=683 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=929 ,top=677 ,right=1114 ,bottom=741 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='관  계' ,left=942 ,top=680 ,right=1090 ,bottom=736 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1455 ,top=677 ,right=1640 ,bottom=741 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='연락처' ,left=225 ,top=672 ,right=355 ,bottom=730 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='ATT_NM', left=582, top=870, right=902, bottom=926, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SCH_FRTO', left=1122, top=873, right=1442, bottom=929, align='left' ,mask='XXXX/XX~XXXX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=1455 ,top=868 ,right=1640 ,bottom=931 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=929 ,top=868 ,right=1114 ,bottom=931 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='기타정보' ,left=209 ,top=910 ,right=376 ,bottom=966 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='최종학력' ,left=405 ,top=870 ,right=553 ,bottom=923 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='신  장' ,left=405 ,top=934 ,right=553 ,bottom=987 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='기  간' ,left=942 ,top=870 ,right=1090 ,bottom=926 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='체  중' ,left=942 ,top=934 ,right=1090 ,bottom=990 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1455 ,top=931 ,right=1640 ,bottom=992 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='송금은행' ,left=402 ,top=743 ,right=550 ,bottom=796 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='예금주' ,left=942 ,top=746 ,right=1090 ,bottom=799 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<X>left=1455 ,top=741 ,right=1640 ,bottom=804 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
	<T>id='송금정보' ,left=209 ,top=783 ,right=376 ,bottom=839 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='송금계좌' ,left=402 ,top=810 ,right=550 ,bottom=863 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='전화번호' ,left=1474 ,top=680 ,right=1622 ,bottom=736 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='전화번호' ,left=1476 ,top=743 ,right=1625 ,bottom=796 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='특  기' ,left=1476 ,top=934 ,right=1625 ,bottom=990 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<T>id='취  미' ,left=1476 ,top=870 ,right=1625 ,bottom=926 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
	<C>id='HOBBY', left=1648, top=870, right=1921, bottom=926, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SPC_NM', left=1648, top=934, right=1921, bottom=990, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHI_NM', left=582, top=683, right=902, bottom=738, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHI_RNM', left=1122, top=683, right=1442, bottom=738, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHI_TEL', left=1648, top=683, right=1921, bottom=738, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SAV_NM', left=1122, top=746, right=1442, bottom=802, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SAV_TEL', left=1648, top=746, right=1921, bottom=802, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REM_BNK_NM', left=582, top=746, right=902, bottom=802, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REM_ACC', left=582, top=810, right=1439, bottom=865, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='cm' ,left=661 ,top=937 ,right=709 ,bottom=992 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HEIGHT', left=582, top=937, right=656, bottom=992, align='right' ,mask='XXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=1</C>
	<C>id='WEIGHT', left=1122, top=937, right=1196, bottom=992, align='right' ,mask='XXX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='kg' ,left=1201 ,top=937 ,right=1249 ,bottom=992 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENG_NM', left=1008, top=212, right=1437, bottom=267, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CUR_DT', left=1601, top=151, right=1934, bottom=206, align='right' ,mask='발행일자:XXXX/XX/XX'</C>
</B>


<A>id=Area2 ,left=0,top=0 ,right=2000 ,bottom=165 ,face=굴림체,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='career.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=162 ,DetailDataID=gcds_report2
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=124 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='직종' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='근무지' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='소속' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='발령구분' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='발령일자' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='※ 사 내 경 력' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=60 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<L> left=489 ,top=0 ,right=489 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<C>id='ORD_NM', left=495, top=3, right=736, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='TEAM_NM', left=749, top=3, right=1143, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='WORK_NM', left=1156, top=3, right=1524, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='JOB_NM', left=1535, top=3, right=1924, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ORD_DT', left=217, top=3, right=479, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area3 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=굴림체,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='family.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report3
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='비고' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='관  계' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='직업' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='생년월일' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='성  명' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='※ 가 족 사 항' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<C>id='{CURROW}', left=111, top=0, right=204, bottom=56, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='FAMI_NM', left=222, top=0, right=482, bottom=56, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='BIRTHDAY', left=495, top=0, right=733, bottom=56 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='JOB_NM', left=751, top=0, right=1146, bottom=56, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REF_NM', left=1162, top=0, right=1519, bottom=56, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REMARK', left=1537, top=0, right=1921, bottom=56, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=489 ,top=0 ,right=489 ,bottom=61 </L>
		</B>
	</R>
</A>

<A>id=Area4 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=굴림체,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='hdorder.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report4
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=124 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1580 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=624 ,top=66 ,right=931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='※ 입사전경력' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=931 ,top=66 ,right=1220 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='직위' ,left=960 ,top=69 ,right=1188 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=1220 ,top=66 ,right=1580 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='퇴직사유' ,left=1603 ,top=69 ,right=1905 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=212 ,top=66 ,right=418 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='입사일' ,left=220 ,top=69 ,right=415 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=418 ,top=66 ,right=624 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='퇴사일' ,left=421 ,top=69 ,right=611 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='회사명' ,left=630 ,top=69 ,right=908 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='담당업무' ,left=1257 ,top=69 ,right=1556 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=60 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=418 ,top=0 ,right=418 ,bottom=61 </L>
			<L> left=624 ,top=0 ,right=624 ,bottom=61 </L>
			<L> left=931 ,top=0 ,right=931 ,bottom=61 </L>
			<L> left=1580 ,top=0 ,right=1580 ,bottom=61 </L>
			<L> left=1220 ,top=0 ,right=1220 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='START_DT', left=220, top=3, right=413, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='END_DT', left=423, top=3, right=616, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='COMPNM', left=630, top=3, right=923, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='POSINM', left=937, top=3, right=1212, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='DUTYNM', left=1225, top=3, right=1572, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REAMRK', left=1585, top=3, right=1926, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area5 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=굴림체,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='license.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report5
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=124 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='발행처' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='증번호' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='자격증명' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='자격면허구분' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='취득일자' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='※ 자 격 면 허' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=60 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=487 ,top=0 ,right=487 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='GET_DT', left=220, top=3, right=479, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='LCS_TYPE_NM', left=492, top=3, right=733, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='LCS_CD_NM', left=749, top=3, right=1138, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='LCS_NO', left=1156, top=3, right=1513, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='ISS_PART', left=1535, top=3, right=1916, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area6 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=굴림체,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='vacation.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report6
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=124 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='휴가사유' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='휴가일수' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='소속' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='※ 휴 가 내 역' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=820 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='휴가종료일' ,left=833 ,top=69 ,right=1146 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=820 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='휴가시작일' ,left=497 ,top=69 ,right=807 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=60 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=487 ,top=0 ,right=487 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<L> left=820 ,top=0 ,right=820 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='TEAM_NM', left=220, top=3, right=482, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='START_DT', left=495, top=3, right=810, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='END_DT', left=831, top=3, right=1138, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='H_DAY', left=1164, top=3, right=1513, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='H_RES', left=1537, top=3, right=1921, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area7 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=굴림체,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='award.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report7
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='상벌내용' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='지급년월' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='포상금' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='상벌구분' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='수여일자' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='※ 상 벌 사 항' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=487 ,top=0 ,right=487 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='RCV_DT', left=225, top=3, right=476, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REW_NM', left=495, top=3, right=728, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REW_AMT', left=759, top=3, right=1138, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='PAY_DT', left=1162, top=3, right=1516, bottom=58 ,mask='XXXX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REW_RK', left=1540, top=3, right=1921, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area9 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=굴림체,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='cloth.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report9
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1580 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1013 ,top=66 ,right=1220 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=706 ,top=66 ,right=1013 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='※ 근 무 복 ' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<X>left=1220 ,top=66 ,right=1580 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=418 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='지급일자' ,left=220 ,top=69 ,right=415 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='지급내역' ,left=712 ,top=69 ,right=990 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='반납일' ,left=1257 ,top=69 ,right=1556 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='옷상태' ,left=1027 ,top=69 ,right=1217 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=418 ,top=66 ,right=706 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='관리코드' ,left=442 ,top=69 ,right=669 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='반납사유' ,left=1603 ,top=69 ,right=1905 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<L> left=418 ,top=0 ,right=418 ,bottom=61 </L>
			<L> left=1580 ,top=0 ,right=1580 ,bottom=61 </L>
			<L> left=1220 ,top=0 ,right=1220 ,bottom=61 </L>
			<L> left=706 ,top=0 ,right=706 ,bottom=61 </L>
			<L> left=1013 ,top=0 ,right=1013 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SUB_DT', left=220, top=3, right=413, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='MAN_NM', left=426, top=3, right=699, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='SUP_NM', left=714, top=3, right=1005, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CLOTH_NM', left=1019, top=3, right=1214, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='RTN_DT', left=1225, top=3, right=1572, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='RTN_RE', left=1585, top=3, right=1929, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
		</B>
	</R>
</A>

<A>id=Area10 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=굴림체,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='education.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report10
	   <B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='교육내용' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='이수여부' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='교육구분' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='교육종료일' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='교육시작일' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='※ 교 육' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=487 ,top=0 ,right=487 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=3, right=206, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDU_CO', left=1537, top=0, right=1921, bottom=56, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='START_DT', left=220, top=3, right=482, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='END_DT', left=495, top=3, right=730, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDU_CD_NM', left=754, top=3, right=1135, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='EDU_YN_NM', left=1162, top=3, right=1527, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<A>id=Area11 ,left=0,top=0 ,right=2000 ,bottom=70 ,face=굴림체,  size=10 ,penwidth=1 ,PageSkip=false
	<R>id='contract.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=68 ,DetailDataID=gcds_report11
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=125 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=1529 ,top=66 ,right=1931 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=1151 ,top=66 ,right=1529 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='비고' ,left=1550 ,top=69 ,right=1916 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='근속년차' ,left=1154 ,top=69 ,right=1519 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=743 ,top=66 ,right=1151 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='계약구분' ,left=749 ,top=69 ,right=1146 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<X>left=489 ,top=66 ,right=743 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=212 ,top=66 ,right=489 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<X>left=106 ,top=66 ,right=212 ,bottom=124 ,backcolor=#B1B1B1 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='계약만료일' ,left=497 ,top=69 ,right=733 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='계약시작일' ,left=214 ,top=69 ,right=487 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
			<T>id='※ 계 약' ,left=106 ,top=8 ,right=1931 ,bottom=66 ,align='left' ,face='HY견고딕' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='No' ,left=111 ,top=69 ,right=206 ,bottom=122 ,face='굴림' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#B1B1B1</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=61 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=106 ,top=0 ,right=106 ,bottom=61 </L>
			<L> left=106 ,top=61 ,right=1931 ,bottom=61 </L>
			<L> left=487 ,top=0 ,right=487 ,bottom=61 </L>
			<L> left=1931 ,top=0 ,right=1931 ,bottom=61 </L>
			<L> left=743 ,top=0 ,right=743 ,bottom=61 </L>
			<L> left=1151 ,top=0 ,right=1151 ,bottom=61 </L>
			<L> left=1529 ,top=0 ,right=1529 ,bottom=61 </L>
			<L> left=212 ,top=0 ,right=212 ,bottom=61 </L>
			<C>id='{CURROW}', left=114, top=0, right=206, bottom=56, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='START_DT', left=222, top=0, right=479, bottom=56 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='END_DT', left=497, top=3, right=738, bottom=58 ,mask='XXXX/XX/XX', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CONT_NM', left=751, top=3, right=1143, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='CON_YEARNM', left=1159, top=3, right=1521, bottom=58, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='REMARK', left=1537, top=3, right=1924, bottom=58, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>

<B>id=Footer ,left=0 ,top=2680 ,right=2000 ,bottom=2870 ,face='굴림' ,size=10 ,penwidth=1
	<T>id='#p/#t' ,left=108 ,top=85 ,right=1934 ,bottom=164</T>
	<L> left=108 ,top=74 ,right=1934 ,bottom=74 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<I>id='../common/img/icon.jpg' ,left=1487 ,top=85 ,right=1868 ,bottom=175</I>
</B>

" />
</object><%=HDConstant.COMMENT_END%>


<!--------------------------------- 코딩 부분 끝 -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp" flush="true" />		


</body></html>