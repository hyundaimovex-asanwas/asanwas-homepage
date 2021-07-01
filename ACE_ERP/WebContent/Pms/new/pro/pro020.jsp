<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 홈>PMS>프로젝트 관리>프로젝트현황
 * 프로그램ID 	 : PMS/PRO020
 * J  S  P		 : pro020.jsp, GAUCE5.x
 * 서 블 릿		 : Pr020
 * 작 성 자		 : 이 동 훈
 * 작 성 일		 : 2018-06-21
 * [ 수정일자 ][수정자] 내용
 * [2018-06-21][이동훈] 전체 프로젝트 현황 조회
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

	    v_fr_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,4)+"01"%>";
        v_to_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)%>";			    
	    
        fnSelect();        
        
    }
    
    
    
    <%//메인 조회 %>
    function fnSelect() {
    	
	    	v_job="S";

	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+ ",v_project=" + v_project.value												//propject명        
				            + ",v_frdt=" + v_fr_date.text.substr(2,4)
				            + ",v_todt=" + v_to_date.text.substr(2,4)							
							+ ",v_prop1=" + lc_gc_prop1.ValueOfIndex("detail", lc_gc_prop1.Index)			//손익센터
							+ ",v_prop2=" + lc_gc_prop2.ValueOfIndex("detail", lc_gc_prop2.Index)			//사업구분
				;

	        ln_TRSetting(tr1, 
				            "<%=dirPath%><%=HDConstant.PATH_PRO%>Pr020",
				            "JSP(O:DS_DEFAULT=ds_default)",
				            param);
	        
	        tr_post(tr1);
	        
        
    }

	

    function fnProjectNoCleanup(){
    	
    	v_project.value = "";
    	
    }

    
	<%//액셀 다운하기%>
    function fnExcelDsDefault() {
    	
        if(ds_default.CountRow==0){
        	
            alert("데이터를 먼저 조회하시길 바랍니다.");
            return;
            
        }
        
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        
        getObjectFirst("gr_default").SetExcelTitle(1, "value:원가코드 현황; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        
        getObjectFirst("gr_default").GridToExcel("원가코드 현황", "원가코드_현황.xls", 8);        
        
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
			     		<td align=left >
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" 	onclick="fnSelect()">						
							<img src="<%=dirPath%>/Sales/images/excel.gif"  	style="cursor:pointer" 	onclick="fnExcelDsDefault()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>
                        <td align=left class="text"  width="100">기간</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=60 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:59px; height:17px;">
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>&nbsp;~&nbsp;
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=60 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:59px; height:17px;">            
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>                   
                
                
                
                        <td align="center" class="text" width="90">프로젝트명</td>
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
                <object id=gr_default classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='450px' border='1'>
                    <param name="DataID"            value="ds_default">
                    <param name="Editable"          value="false">
                    <param name="BorderStyle"       value="0">
                    <param name="SuppressOption"    value="1">
					<Param Name="UsingOneClick"     value="1">
					<param name="ViewSummary"       value="1">
					<Param Name="SortView"     		value="Right">                    
                    <param name="Format"            value="
						<C> name='No'				ID='{CurRow}'		 	width=30 	align=CENTER	edit=none </C>	
                        <C> name='코드'		 		ID='COST_CD'    		width=80 	align=center 	edit=none </C>				
						<C> name='프로젝트'   	 	ID='PLJ_NM'   	 		width=350 	align=left	 	edit=none </C>
						<C> name='대분류'   		ID='PROP1' 				width=80 	align=center	editstyle=lookup Data='ds_gc_prop1:detail:detail_nm' SumText=@count</C>
						<C> name='중분류'   		ID='PROP2' 				width=80 	align=center	editstyle=lookup Data='ds_gc_prop2:detail:detail_nm' SumText='건'</C>

                        <C> name='담당팀'		 	ID='PL_DEPT_NM'			width=110 	align=center  	edit=none </C>
                        <C> name='시작일'	 		ID='CTRT_BGNDATE'  		width=70 	align=center 	show=false mask='XXXX-XX-XX'</C>
                        <C> name='종료일'	 		ID='CTRT_ENDDATE'  		width=70 	align=center 	show=false mask='XXXX-XX-XX'</C>
                        <C> name='발주처'	 		ID='ORDER_COMP_NM'  	width=100 	align=left   	edit=none </C>
                        <C> name='수주액'    		ID='WIN_FEE'	 		width=80 	align=right	 	decao=0  show=false</C>
                        <C> name='FILE_KEY'		 	ID='FILE_KEY'    		width=150 	align=center  	</C>
                        <C> name='사용'			 	ID='USE_YN'    			width=40 	align=center 	show=false</C>
                        <C> name='수주일'	 		ID='WIN_DATE'  			width=70 	align=center 	mask='XXXX-XX-XX' show=false</C>
                        <C> name='수행PM'			ID='PM_NM'   			width=70 	align=center 	show=false </C>
                        <C> name='원가'      		ID='COST_FEE'	 		width=80 	align=right	 	show=false decao=0  </C>
                        <C> name='특이사항'		 	ID='NOTE'   			width=70 	align=center 	show=false</C>
					">                             
                </object>                        
            </td>
        </tr>
        
		<tr height='6px'>
            <td></td>
        </tr>
        
        <tr>
            <td valign="top">
            <!-- 뷰 화면 -->        
                <table  border='0' cellpadding='0' cellspacing='0'>
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
				                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:60px;">
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
	<C>Col=PROP1			Ctrl=txt_prop1			Param=value</C>	
	<C>Col=PROP2			Ctrl=txt_prop2			Param=value</C>	
	<C>Col=ORDER_COMP_NM	Ctrl=txt_order_nm		Param=value</C>	
	<C>Col=PM_NM			Ctrl=txt_pm_nm			Param=value</C>		
	
	'>
</object>
<%=HDConstant.COMMENT_END%>  


<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		