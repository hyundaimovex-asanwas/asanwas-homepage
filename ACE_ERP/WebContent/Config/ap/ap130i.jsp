<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 결재함 - 서비스
 * 프로그램ID 	: my410i
 * J  S  P		: my410i
 * 서 블 릿		: My410I
 * 작 성 자		: 심동현
 * 작 성 일		: 2010-08-20
 * [ 수정일자 ][수정자] 내용
 * [2010-08-20][심동현] 최초 제작.
 *						서비스요청서 전자결재의 미결함 - 로긴 사용자가 결재할 차례인 문서를 조회
 *						그리드 행을 더블클릭하면 결재 상세 팝 ~ 팝의 상단부= 공통결재모듈, 중단은 결재문서의 정보
 *						 하단은 첨부파일 모듈(이 파일들의 저장경로랑 용량도 문제임)
 * [2014-06-27][심동현] 공사/작업일보 결재화면 추가
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="config.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
		
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());		
	//세션 불러오기 시작
	String v_login_name ="";
	String v_login_id = "";
	v_login_id=(String)session.getAttribute("vusrid");
	v_login_name=(String)session.getAttribute("vusrnm");
	//세션 불러오기 끝
%>
<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Config/common/include/head.jsp"/>
    
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
		<script language="javascript">
		 var div='';
		// 페이지로딩
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//트리초기화 호출

			cfStyleGrid(getObjectFirst("gr1"), "comn");
				
			fnInit();
		} 
		 
		function fnInit() {
			div = 'init';
			
			ds_doc_gu.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=AP001&s_item1=Y";
            ds_doc_gu.Reset();	//결재 문서구분
			ds_doc_gu2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=AP006&s_item1=Y";
            ds_doc_gu2.Reset();	//결재 문서구분2
            v_to_input_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
            v_fr_input_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,4)%>0101";

			
		}
		
		// 메인 조회
		function fnSelect() {
        	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",v_empno="+ sNowEmpno.value
			          + ",v_fr_date=" + getObjectFirst("v_fr_input_date").Text
			          + ",v_to_date=" + getObjectFirst("v_to_input_date").Text
			          + ",v_doc_gu=" + v_doc_gu.ValueOfIndex("detail", v_doc_gu.Index)
			          + ",v_doc_gu2=" + v_doc_gu2.ValueOfIndex("detail", v_doc_gu2.Index)
						;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AP%>Ap130I",
			    "JSP(O:MASTER=ds1)",
			    param);
			   
			tr_post(tr1);
		}
			

		// 적용
		function fnApply() {
		}



</script>

<%
/****************************************************************************
			가우스 이벤트 스크립트
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="작업이 성공적으로 완료되었습니다.";
	</script>	
	

<%
/****************************************************************************
			가우스 컴포넌트 이벤트 스크립트
******************************************************************************/
%>
<script language=javascript for=gr1 event="OnDblClick(Row,Colid)">
     if(Row==0) return;
    
    var result="";
    var arrParam	= new Array();
    var arrResult	= new Array();
   
    //중요정보인 경우
	if(ds1.namevalue(Row,"doc_gu")=="00"){
	    //정보등록
		if(ds1.namevalue(Row,"doc_gu2")=="010"){ 
		  
		  arrParam[0]="010";                                                               //AP006 ( 010 정보등록, 020 정보배포,030 정보수신,040 정보열람,100 서비스요청 
		  arrParam[1]=ds1.namevalue(ds1.rowposition,"DOC_SID");  //문서SID 
		  arrParam[2]="";                                                                    // 결재선정보 
		  arrParam[3]=ds1.namevalue(Row,"ap_m_sid");                   // 결재SID 
		  strURL = "<%=dirPath%>/Security/help/li0100h.jsp?";
		  strPos = "dialogWidth:740px;dialogHeight:480px;status:no;scroll:no;resizable:no";
	
	      result = showModalDialog(strURL,arrParam,strPos);
	      
	      if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
          }     
		}
		
		//정보배포
		if(ds1.namevalue(Row,"doc_gu2")=="020"){ 
		  
		  arrParam[0]="020";                                                               //AP006 ( 010 정보등록, 020 정보배포,030 정보수신,040 정보열람,100 서비스요청 
		  arrParam[1]=ds1.namevalue(ds1.rowposition,"DOC_SID");  //문서SID 
		  arrParam[2]="";                                                                    // 결재선정보 
		  arrParam[3]=ds1.namevalue(Row,"ap_m_sid");                   // 결재SID 
		  strURL = "<%=dirPath%>/Security/help/li0200h.jsp?";
		  strPos = "dialogWidth:740px;dialogHeight:480px;status:no;scroll:no;resizable:no";
	
	      result = showModalDialog(strURL,arrParam,strPos);
	      
	      if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
          }     
		}
		
		//정보수신 열람
		if(ds1.namevalue(Row,"doc_gu2")=="030"||ds1.namevalue(Row,"doc_gu2")=="040"){ 
		  
		  arrParam[0]="030";                                                               //AP006 ( 010 정보등록, 020 정보배포,030 정보수신,040 정보열람,100 서비스요청 
		  arrParam[1]=ds1.namevalue(ds1.rowposition,"DOC_SID");  //수신열람번호 
		  arrParam[2]="";                                                                    // 결재선정보 
		  arrParam[3]=ds1.namevalue(Row,"ap_m_sid");                   // 결재SID 
		  strURL = "<%=dirPath%>/Security/help/li0300h.jsp?";
		  strPos = "dialogWidth:740px;dialogHeight:480px;status:no;scroll:no;resizable:no";
	
	      result = showModalDialog(strURL,arrParam,strPos);
	      
	      if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
          }     
		}
		
	}

	//관광인 경우
	if(ds1.namevalue(Row,"doc_gu")=="20"){
		//100==서비스인 경우
		if(ds1.namevalue(Row,"doc_gu2")=="100"){
			var apURL ="<%=dirPath%>/Sales/help/my400h.jsp?ap_m_sid="+ds1.namevalue(Row,"ap_m_sid");
		   	window.open(apURL,"ap_doc_service","width=720,height=585,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
		}
	}

	//구매_자재청구인 경우
	if(ds1.namevalue(Row,"doc_gu2")=="310"){ 
		  
		  arrParam[0]="310";                                                               //AP006 ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 .310 자재청구, 320 자재청구접수, 330 구매품의)
		  arrParam[1]=ds1.namevalue(ds1.rowposition,"DOC_SID");  //요청SID
		  arrParam[2]="";                                                                    // 결재선정보 
		  arrParam[3]=ds1.namevalue(Row,"ap_m_sid");                   // 결재SID 
		  //alert(arrParam);
		  strURL = "<%=dirPath%>/Pms/help/pu010h.jsp?";
		  strPos = "dialogWidth:900px;dialogHeight:800px;status:no;scroll:no;resizable:no";
			
	      result = showModalDialog(strURL,arrParam,strPos);
	      
	      if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
          }     
		}
		
	//구매_자재청구접수인 경우
	if(ds1.namevalue(Row,"doc_gu2")=="320"){ 
		  
		  arrParam[0]="320";                                                               //AP006 ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 .310 자재청구, 320 자재청구접수, 330 구매품의)
		  arrParam[1]=ds1.namevalue(ds1.rowposition,"DOC_SID");  //요청SID
		  arrParam[2]="";                                                                    // 결재선정보 
		  arrParam[3]=ds1.namevalue(Row,"ap_m_sid");                   // 결재SID 
		  //alert(arrParam);
		  strURL = "<%=dirPath%>/Pms/help/pu020h.jsp?";
		  strPos = "dialogWidth:900px;dialogHeight:800px;status:no;scroll:no;resizable:no";
	
	      result = showModalDialog(strURL,arrParam,strPos);
	      
	      if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
          }     
		}
	
	//구매_품의서작성인 경우
	if(ds1.namevalue(Row,"doc_gu2")=="330"){ 
		  
		  arrParam[0]="330";                                                               //AP006 ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 .310 자재청구, 320 자재청구접수, 330 구매품의)
		  arrParam[1]=ds1.namevalue(ds1.rowposition,"DOC_SID");  //요청SID
		  arrParam[2]="";                                                                    // 결재선정보 
		  arrParam[3]=ds1.namevalue(Row,"ap_m_sid");                   // 결재SID 
		  //alert(arrParam);
		  strURL = "<%=dirPath%>/Pms/help/pu030h_01.jsp?";
		  strPos = "dialogWidth:1000px;dialogHeight:900px;status:no;scroll:no;resizable:no";
	
	      result = showModalDialog(strURL,arrParam,strPos);
	      
	      if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
          }     
		}
		
	//구매_검수인 경우
	if(ds1.namevalue(Row,"doc_gu2")=="340"){ 
	  
	  arrParam[0]="340";                                                               //AP006 ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 .310 자재청구, 320 자재청구접수, 330 구매품의)
	  arrParam[1]=ds1.namevalue(ds1.rowposition,"DOC_SID");  //요청SID
	  arrParam[2]="";                                                                    // 결재선정보 
	  arrParam[3]=ds1.namevalue(Row,"ap_m_sid");                   // 결재SID 
	  arrParam[4]=ds1.namevalue(ds1.rowposition,"NUM_PARAM2");  //CGCD_SID
	  arrParam[5]=ds1.namevalue(ds1.rowposition,"NUM_PARAM3");  //RQST_SID
	  arrParam[6]=ds1.namevalue(ds1.rowposition,"NUM_PARAM4");  //EST_SID
	  arrParam[7]=ds1.namevalue(ds1.rowposition,"CH_PARAM1");    //DATE_CGCD
	  //alert(arrParam);
	  strURL = "<%=dirPath%>/Pms/help/pu040h_02.jsp?";
	  strPos = "dialogWidth:1000px;dialogHeight:900px;status:no;scroll:no;resizable:no";
	
      result = showModalDialog(strURL,arrParam,strPos);
      
      if(result != null){
		arrResult = result.split(";");
		if(arrResult[0]=="Y"){
			 fnSelect(); 
		}
      }     
	}

	// 공사인 경우
	if(ds1.namevalue(Row,"doc_gu")=="40"){	//결재한 문서니까. 승인/반송 버튼은 없음
		var v_sts = "000";	//순수 조회모드
	    // 작업일보
		if(ds1.namevalue(Row,"doc_gu2")=="400"){
			var link ="<%=dirPath%>/Pms/si/si110i_h1.jsp?v_dwr_sid="+ ds1.namevalue(Row,"doc_sid") +"&v_status="+ v_sts +"&v_ap_m_sid="+ ds1.namevalue(Row,"ap_m_sid");
	        var dialogWidth = 930; 
	        var features ="top=0,left="+ ((screen.availWidth - dialogWidth) / 2)+",height="+(screen.availHeight-52)+", width="+dialogWidth+",toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes";
	        var pop_ap_dwr2 = window.open(link, 'pop_ap_dwr2', features); 
	    
		}
	}
		
	//메뉴권한인 경우
	if(ds1.namevalue(Row,"doc_gu")=="90"){
		alert("90메뉴권한");
	}
</script>
	
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_doc_gu classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//결재 문서구분%>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_doc_gu2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//결재 문서구분2%>
    <param name="SyncLoad"  value="True">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td style="padding-bottom:6px" align=right>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:pointer"	onclick="fnSelect()">&nbsp;
						</td>
					</tr>
					<tr>
						<td>
							<table border='0' cellpadding='0' cellspacing='1' bgcolor='#666666' width=845>
							  <tr>
								<td align="center" width="100px" height="25px" class="text" >관리자</td>
								<td align="left"  bgcolor="#ffffff">&nbsp;
		                            <input type="text" name='sNowEmpnm' id='sNowEmpnm' value='<%=v_login_name%>' size='8' readonly='readonly'  class='boardt04'>
		                            <input type="text" name='sNowEmpno' id='sNowEmpno' value='<%=v_login_id%>' size='7' readonly='readonly'  class='boardt04'>
								</td>
								 <td width="100px" class="text">기안일자</td>
	                             <td align="left" bgcolor="#ffffff">&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=v_fr_input_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
		                                <param name=Text        value="">
		                                <param name=Alignment   value=1>
		                                <param name=Format      value="0000-00-00">
		                                <param name=Cursor      value="iBeam">
		                                <param name=Border      value="false">      
		                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
		                                <param name=ReadOnly    value="false">
		                                <param name=SelectAll   value="true">
		                                <param name=SelectAllOnClick    value="true">
		                                <param name=SelectAllOnClickAny   value=false>
		                            </object>&nbsp;~&nbsp;
		                            <object id=v_to_input_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
		                                <param name=Text        value="">
		                                <param name=Alignment   value=1>
		                                <param name=Format      value="0000-00-00">
		                                <param name=Cursor      value="iBeam">
		                                <param name=Border      value="false">      
		                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
		                                <param name=ReadOnly    value="false">
		                                <param name=SelectAll   value="true">
		                                <param name=SelectAllOnClick    value="true">
		                                <param name=SelectAllOnClickAny   value=false>
		                            </object>
		                            <%=HDConstant.COMMENT_END%> 
                                </td>
				              </tr>
							  <tr>
								<td align=left class="text">문서구분1</td>
                                <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_doc_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
                                    	<param name=ComboDataID     value=ds_doc_gu>
                                    	<param name=ListExprFormat  value="detail_nm^0^70">                                        
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
								</td>
								<td align=left class="text">문서구분2</td>
                                <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
                                    <object id=v_doc_gu2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
                                    	<param name=ComboDataID     value=ds_doc_gu2>
                                    	<param name=ListExprFormat  value="detail_nm^0^70">                                        
                                    </object>
                                    <%=HDConstant.COMMENT_END%>
								</td>
				            </tr>					              
						  </table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
		</tr>
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              <C> name='결재번호'   ID='ap_m_sid'   	width=70	align=center editlimit=5 show=true edit=none</C>
						              <C> name='구분1'    	ID='doc_gu_nm'   	width=70 	align=center editlimit=50 show=true suppress=1 edit=none</C>
						              <C> name='구분2'    	ID='doc_gu_nm2'   	width=90 	align=center editlimit=50 show=true suppress=1 edit=none</C>
						              <C> name='진행상태'   ID='ap_status_m_nm'	width=60 	align=center editlimit=30 show=true edit=none</C>
									  <G> name='최종결재자'
						         	  <C> name='사번' 		ID='l_empno'     	width=60 	align=center editlimit=30 show=true edit=none</C>
						              <C> name='성명'  	  	ID='l_empnm'   		width=60 	align=center editlimit=30 show=true edit=none</C>
								  	  </G>
						              <G> name='기안자'
							   		  <C> name='사번'  		ID='i_empno'    	width=60 	align=center editlimit=10 show=true edit=none</C>
							          <C> name='성명'     	ID='i_empnm'       	width=60 	align=center editlimit=10 show=true edit=none</C>
									  </G>
						              <C> name='기안일시' 	ID='i_date' 		width=180 	align=left editlimit=10 show=true edit=none</C>
						              <C> name='의견 수'    ID='cnt_desc'   	width=60	align=center editlimit=14 show=true edit=none</C>
											  <C> name='문서구분1'     	ID='doc_gu'       	width=60	align=center show=FALSE </C>
											  <C> name='문서구분2'     	ID='doc_gu2'       	width=60	align=center show=FALSE </C>
								              <C> name='문서SID'		ID='doc_sid'   		width=100 	align=left editlimit=20 edit=none show=false</C>
								              <C> name='진행상태'    	ID='ap_status_m'   	width=60 	align=center editlimit=16 show=FALSE edit=none</C>
								              <C> name='총 결재선'      ID='cnt_all_ap'     width=60 	align=center editlimit=50 show=false edit=none</C>
								              <C> name='미결 갯수'   	ID='cnt_not_ap'  	width=60 	align=center editlimit=61 show=false edit=none</C>
								              <G> name='수정자'
								         	  <C> name='사번'     	ID='u_empno'     	width=60 	align=center editlimit=10 show=false edit=none</C>
							              	  <C> name='성명' 		ID='u_empnm' 		width=60 	align=center editlimit=12 show=false edit=none</C>
										      </G>
               					">
							</object>    
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>

			</td>
		</tr>

		<tr>
			<td>※ 결재함 : 사용자가 결재과정에 참여한 문서만 조회됩니다. <br>
			※ 기안문서는 [기안함]에서 조회해 주시기 바랍니다.
			</td>
		</tr>

	</table>
	
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

