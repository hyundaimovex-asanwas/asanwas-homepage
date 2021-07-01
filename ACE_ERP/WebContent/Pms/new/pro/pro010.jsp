<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>PMS>프로젝트 관리>프로젝트 코드 관리
 * 프로그램ID 	 : PMS/PRO010
 * J  S  P		 : pro010.jsp, GAUCE5.x
 * 서 블 릿		 : Pr010
 * 작 성 자		 : 이 동 훈
 * 작 성 일		 : 2018-06-20
 * [ 수정일자 ][수정자] 내용
 * [2018-06-20][이동훈] 전체 프로젝트 현황 조회
 *						
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="sales.menu.my.My710DTO" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작 : doctype를 html5로-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
    <!--  head.jsp -->
    <jsp:include page="/Pms/common/include/head.jsp"/>
    <!--  //head.jsp -->
    

	<!-- 첨부 파일을 위해 -->
    <jsp:include page="../../common/fileupload.jsp" flush="true" />
    <!-- 첨부 파일을 위해 -->   
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">

	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	
	var menuWin;	//새창 띄우기용.
	
	var v_todt = "<%=DateUtil.getCurrentDate(8)%>";
	
	var count = 0;
	/*
	 * 페이지로딩
	 */
	 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		cfStyleGrid(getObjectFirst("gr_default"), "comn");	//project list

		fnInit();
		
	}
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";
	    

        ds_gc_prop1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY201&s_item1=Y";
        ds_gc_prop1.Reset();	//손익센터
        
        
        ds_gc_prop2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY202&s_item1=Y";
        ds_gc_prop2.Reset();	//사업구분
        

    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	
	    	v_job="S";
	    	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+ ",v_project=" + v_project.value												//propject명        
							+ ",v_prop1=" + lc_gc_prop1.ValueOfIndex("detail", lc_gc_prop1.Index)			//손익센터
							+ ",v_prop2=" + lc_gc_prop2.ValueOfIndex("detail", lc_gc_prop2.Index)			//사업구분
				;
	        

	        ln_TRSetting(tr1, 
				            "<%=dirPath%><%=HDConstant.PATH_PRO%>Pr010",
				            "JSP(O:DS_DEFAULT=ds_default)",
				            param);
	        
	        tr_post(tr1);
	        
        
     	        
	        
    }


	<%//저장 %>
	function fnSave(){
		
		v_job = "A";
		
		v_default_row = ds_default.RowPosition;
		
		if (ds_default.IsUpdated) {
			
			if(ln_Chk()){
				
				  ln_TRSetting(tr1, 
			                "<%=dirPath%><%=HDConstant.PATH_PRO%>Pr010",
			                "JSP(I:DS_DEFAULT=ds_default)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                	);

	        		tr_post(tr1);
        		
        	}
			
		}else {
			

	 	}
		
	}
	
	

	<%// 입력값 체크 %>
	function ln_Chk() {	
		
		return true;
		
	}    
    
    

	
	<%// 신규 등록 %>
	function fnNew() {	

		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;
		
		strURL = "<%=dirPath%>/Pms/new/pro/pro011.jsp";
		
		strPos = "dialogWidth:410px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,arrParam,strPos);
		
		fnSelect();
		
	}  	
	
	
	<%// 삭제 %>
	function fnDelete() {	

		v_job = "D";
		
		v_default_row = ds_default.RowPosition;
		
		if(ds_default.namevalue(v_default_row,"STATUS_NOW") != "S") {
			
            alert("해당건은 삭제 불가능합니다.");
            return;

		}
		
		
        if( confirm("해당건을 삭제하시겠습니까?") ){
        	
			
        	  ds_default.deleterow(ds_default.rowposition);
        	 
			  ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_PRO%>Pr010",
		                "JSP(I:DS_CULD=ds_default)",
		                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
              	);

      		tr_post(tr1);
            
        }     
		
	}  	
	
	
	<%//직원 팝- 조회 조건%>
    function fnEmpNoPopup(dirPath){
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	if (arrResult != null) {
    		
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		v_mgr_no.value = arrParam[1];
    		v_mgr_nm.value = arrParam[0];
    		
        } else {
        	
			fnEmpNoCleanup();
			
        }               
    	
    }
    
    

    function fnProjectNoCleanup(){
    	
    	v_project.value = "";
    	
    }

    
    
    
	<%//요청 %>
	function fnApply(){
		
		v_job = "R";
		
		v_default_row = ds_default.RowPosition;
		
        if( confirm("해당건을 등록 요청하시겠습니까?") ){
        	
			  ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_PRO%>Pr010",
		                "JSP(I:DS_CULT=ds_default)",
		                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
              	);

      		tr_post(tr1);
            
        }      
		
	}
    
    
	
	
	
    
	<%//액셀 다운하기%>
    function fnExcel() {
    	
        if(ds_default.CountRow==0){
        	
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
            
        }
        
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        
        getObjectFirst("gr_default").SetExcelTitle(1, "value:신청 현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        
        getObjectFirst("gr_default").GridToExcel("신청 현황", "신청_현황.xls", 8);        
        
    }

    
    
    

 	<%//첨부파일 처리%>
	function fnc_FileUpload() {

		
        if(dsFILE.CountRow == 1) {
            alert("파일은 하나만 업로드하시기 바랍니다.");
            return;
        }

        var key = ds_default.NameValue(ds_default.RowPosition, "FILE_KEY");


        if(key == "") {
        	
            key = "pro010"+(new Date().getTime());

            ds_default.NameValue(ds_default.RowPosition, "FILE_KEY") = key;
            
        }

        //alert(ds_default.NameValue(ds_default.RowPosition, "FILE_KEY"));
        
        if(!fnc_AddFileImg(key)) {
        	
        	
            if( confirm("첨부된 파일을 바로 저장하시겠습니까?") ){
            	
            	fnSave();
                
            }              	
        	
            return;
            
        }
        
        
  
        
        
	}


     
  	<%//첨부파일 삭제%>
	function fnc_FileDelete() {
		
        if(dsFILE.CountRow < 1) {
        	
            alert("삭제할 파일이 존재하지 않습니다.");
            
            return;
        }

        if( confirm("첨부된 파일을 삭제하시겠습니까?") ){
        	
            dsFILE.DeleteRow(dsFILE.RowPosition);
            
            fnc_DelFile();
            
        }
	}
    
    
    
    
    
    
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//마스터 그리드 OnClick %>
	<script language="javascript"  for=gr_default event=OnClick(Row,Colid)>
	

			
	</script>



    <!-----------------------------------------------------+
    | Grid 클릭시 진행상태에 따른 버튼 및 필드 활성화 처리			   |
    +------------------------------------------------------>
    <script language=JavaScript for=ds_default event=OnRowPosChanged(row)>
    
        //입력 못하게 막기

        if(row > 0) {
            //등록된 파일들 조회
            fnc_GetFileList(ds_default.NameValue(row, "FILE_KEY"));

        }
	</script>


	<!-- 파일 그리드 클릭시 다운로드 되게 -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>

        if(row > 0) {

            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");

            // 첨부 파일이 존재하는 경우만 수행하게~
            if (vFILE_NAME != "" && vFILE_URL != "") {
				cfDownload(vFILE_NAME,vFILE_URL);
            }
        }
        
    </script>



	<script language="javascript"  for=gr_default event=OnCheckClick(Row,Colid,Check)>

		//alert(count);	
	
		if(ds_default.namevalue(Row,"JOB_SEL") == "T") {
		
			count = count + 1;

			if(count != "1") {
				alert("한건씩 신청하시기 바랍니다");
				ds_default.namevalue(Row,"JOB_SEL") = "F";

			}			
			
		}else{
			count = 0;
		}

		

		
	</script>	
	
	
	

	<%//마스터 : 팝업  %>	
	<script language=JavaScript for=gr_default event=OnPopup(row,colid,data)>
	
		if(colid=="EMP_NM") {
			//alert(row);
			fnEmpNoPopup1('<%=dirPath%>', row);
		}
		
		if(colid=="VEND_NM") {
			
			//alert(row);
			fnVenderPopup('<%=dirPath%>', row);
		}
		

	</script>
	
	
	<script language=JavaScript for=lc_gc_prop1 event=OnSelChange()>
		fnSelect();
	</script>


	<script language=JavaScript for=lc_gc_prop2 event=OnSelChange()>
		fnSelect();
	</script>

	
		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">


	if(v_job=="A"){
		alert("성공적으로 저장되었습니다.");
		fnSelect(); // 디테일들 조회하기
	}
	
	if(v_job=="R"){
		alert("성공적으로 요청되었습니다.");
		count = 0;
		fnSelect(); // 디테일들 조회하기
	}	
	
	if(v_job=="D"){
		alert("성공적으로 삭제되었습니다.");
		count = 0;
		fnSelect(); // 디테일들 조회하기
	}	
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>
<object id=ds_default classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_prop1 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_prop2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>


<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>


</head>

<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->


<!--------------------------------- 코딩 부분 시작 ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0'> 
		<tr>
            <td class="r">
                <table border='0' cellpadding='0' cellspacing='0' width='890px'>
                    <tr>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" 	onclick="fnSelect()">&nbsp;                     
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:pointer"  onClick="fnNew();">&nbsp;	
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" 	onClick="fnSave();">&nbsp;	 
							<img src="<%=dirPath%>/Sales/images/delete.gif"		style="cursor:pointer" 	onClick="fnDelete();">&nbsp;	                    
						<!--<img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:pointer" 	onclick="fnExcel()"> -->
							<img src="<%=dirPath%>/Sales/images/refund_rq.gif"  style="cursor:pointer" 	onclick="fnApply()">&nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>
                        <td align="center" class="text" width="90">원가명</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_project' id="v_project" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
							<img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnProjectNoCleanup();" alt="값 지우기">
                        </td>
                        

                        <td align="center" class="text" width="90">대분류</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_prop1 classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
                                <param name=ComboDataID     	value=ds_gc_prop1>
								<param name=BindColumn      	value="detail">
								<param name=BindColVal      	value="detail">
								<param name=EditExprFormat  	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  	value="detail_nm^0^150">
                            </object>
                        </td>
                        
                        <td align="center" class="text" width="90">중분류</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_prop2 classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
                                <param name=ComboDataID     	value=ds_gc_prop2>
								<param name=BindColumn      	value="detail">
								<param name=BindColVal      	value="detail">
								<param name=EditExprFormat  	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  	value="detail_nm^0^150">
                            </object>
                        </td>

					</tr>
           		</table>
            </td>
        </tr> 
        
        <tr height='10px'>
            <td></td>
        </tr>
        
        <tr>
            <td valign="top">
                <object id=gr_default classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='400px' border='1'>
                    <param name="DataID"            value="ds_default">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
					<Param Name="UsingOneClick"     value="1">
					<param name="ViewSummary"       value="1">
					<Param Name="SortView"     		value="Right">                    
                    <param name="Format"            value="
						<C> name='Chk'          	ID='JOB_SEL'    		Width=30    EditStyle='CheckBox' edit={IF(STATUS_NOW = 'S','true','false')} </C>
                        <C> name='신청코드'		 	ID='REQUEST_CD'    		width=80 	align=center 	edit=none </C>						
						<C> name='신청명'   	 	ID='REQUEST_NM'   	 	width=250 	align=left	 	edit=none </C>
						<C> name='대분류'   		ID='PROP1' 				width=80 	align=center	edit=none editstyle=lookup Data='ds_gc_prop1:detail:detail_nm' SumText=@count</C>
						<C> name='중분류'   		ID='PROP2' 				width=80 	align=center	edit=none editstyle=lookup Data='ds_gc_prop2:detail:detail_nm' SumText='건'</C>
                        <C> name='담당팀'		 	ID='DEPT_NM'			width=100 	align=center  	edit=none </C>
                        <C> name='발주처'	 		ID='COMPANY_NM'  		width=220 	align=left   	edit=none </C>
                        <C> name='수행PM'			ID='PM_NM'   			width=70 	align=center 	edit=none </C>
                        <C> name='상태'		 		ID='STATUS_NOW'   		width=50 	align=center 	show=false</C>   
                        <C> name='상태'		 		ID='FILE_KEY'   		width=70 	align=center 	show=false</C>            
                        <C> name='상태'		 		ID='STATUS_NM'   		width=70 	align=center 	edit=none </C>
					">                             
                </object>                        

            </td>
        </tr>
        
		<tr height='6px'>
            <td></td>
        </tr>
        
        <tr>
            <td valign="top">
					<tr>
						<td>&nbsp;
						</td>
					</tr>
					
					<tr>
						<td>
						<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;■ 파일첨부</font>
						</td>					
					</tr>
					<tr>						
						<td>
				                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:80%;height:60px;">
				                    <param name="DataID" 				value="dsFILE">
				                    <param name="Editable" 				value="false">
				                    <param name="DragDropEnable" 		value="true">
				                    <param name="SortView" 				value="Left">
				                    <param name=ViewHeader  			value="false">
				                    <param name="Format" 				value='
				                        <C> id="{CUROW}"    width="30"      name="NO"          align="center"  value={String(Currow)}</C>
				                        <C> id=FILE_NAME    width="700"     name="파일명"      align="left"    leftmargin="10"</C>
				                    '>
				                </object>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','../../../Ehr/images/button/FileAddOver.gif',1)"><img src="../../../Ehr/images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','../../../Ehr/images/button/FileDelOver.gif',1)"><img src="../../../Ehr/images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
        
    </table>


<input type="hidden" name="row" value="">	
<%
/*=============================================================================
			Bind 선언
=============================================================================*/
%>	

<%=HDConstant.COMMENT_START%>
<object  id=bn1 classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<param name=DataID    value=ds_default>
	<param name=BindInfo  value='  

	<C>Col=plj_nm			Ctrl=txt_project_nm		Param=value</C>
	<C>Col=cost_cd			Ctrl=txt_project_cd		Param=value</C>	

	<C>Col=CTRT_BGNDATE		Ctrl=txt_startymd		Param=value</C>	
	<C>Col=CTRT_ENDDATE		Ctrl=txt_endymd			Param=value</C>	
	
	<C>Col=ORDER_COMP_NM	Ctrl=txt_order_nm		Param=value</C>	
	<C>Col=PM_NM			Ctrl=txt_pm_nm			Param=value</C>		
	
	'>
</object>
<%=HDConstant.COMMENT_END%>  


<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		