
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	
    SmartRequest sr = new SmartRequest(request);
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");

%>

<!-- HTML 시작-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
	<jsp:include page="/Pms/common/include/head.jsp"/>	
	

<script language="javascript">

	var v_default_row = 1;
	
    var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용

	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		cfStyleGrid(getObjectFirst("gr_default"), "comn");	//project list

		fnInit();

	}
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";
	    
	    v_fr_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,4)+"01"+"01"%>";
        v_to_date.Text = "<%=DateUtil.getCurrentDate(8)%>";			    
	    
        fnSelect();
        
    }
    
    
    <%//기본 조회  %>
    function fnSelect() {
    	
   	 	v_job="S";

    	// 검색 값 관련 
    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
								            + ",v_frdt=" + v_fr_date.text
								            + ",v_todt=" + v_to_date.text	   	
    										+ ",v_order=" + v_order.value						//수주코드  	
    										;
   		
	   	ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_BID%>Bid030",
		            "JSP(O:DS_DEFAULT=ds_default)",
		            param);

        tr_post(tr1);
   
    }


    <%//신규 작업 %>
    function fnAdd() {
    	
	    v_job ="A";

		var arrParam	= new Array();;
		var arrResult	= new Array();
		var strURL;
		var strPos;

		strURL = "<%=dirPath%>/Pms/new/bid/bid035.jsp";
	
		strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:no";
	
		arrResult = showModalDialog(strURL,arrParam,strPos);
	
		fnSelect();	    

    }

    
    <%//출력 작업 %>
    function fnPrint() {
    	
    	ds_report.setDataHeader("DEPT_NM:STRING,PERSON:STRING,ORDER_NM:STRING,CONTENT:STRING,PERIOD:STRING,COMPANY_NM:STRING,CONTRACT_AMT:DECIMAL,EXECUTE_AMT:DECIMAL,SALES_PROFIT:DECIMAL,PROFIT_RATE:STRING,REMARK:STRING");
        
    	ds_report.Addrow();  
    	
    	ds_report.namevalue(1, "DEPT_NM" )      = ds_default.namevalue(ds_default.rowposition, "DPT_NM" );
    	ds_report.namevalue(1, "PERSON" )       = ds_default.namevalue(ds_default.rowposition, "PERSON" );    	
    	ds_report.namevalue(1, "ORDER_NM" )     = ds_default.namevalue(ds_default.rowposition, "ORDER_NM" );
    	ds_report.namevalue(1, "CONTENT" )      = ds_default.namevalue(ds_default.rowposition, "CONTENT" );
    	ds_report.namevalue(1, "PERIOD" )       = ds_default.namevalue(ds_default.rowposition, "PERIOD" );
    	ds_report.namevalue(1, "COMPANY_NM" )   = ds_default.namevalue(ds_default.rowposition, "COMPANY_NM" );
   		ds_report.namevalue(1, "CONTRACT_AMT" ) = ds_default.namevalue(ds_default.rowposition, "CONTRACT_AMT" );
   		ds_report.namevalue(1, "EXECUTE_AMT" )  = ds_default.namevalue(ds_default.rowposition, "EXECUTE_AMT" );
   		ds_report.namevalue(1, "SALES_PROFIT" ) = ds_default.namevalue(ds_default.rowposition, "SALES_PROFIT" );
   		ds_report.namevalue(1, "PROFIT_RATE" )  = ds_default.namevalue(ds_default.rowposition, "PROFIT_RATE" );
   		ds_report.namevalue(1, "REMARK" )       = ds_default.namevalue(ds_default.rowposition, "REMARK" );
    	
    	
    	ReportID.Preview();   

    }    

    
</script>
    

<!-- 더블클릭 팝업창 for=gr_default  -->
 <script language=JavaScript for=gr_default event=OnDblClick(row,colid)>

	  		var order_cd =ds_default.NameValue(ds_default.rowposition,"ORDER_CD");

			var arrParam	= new Array();;
			var arrResult	= new Array();
			var strURL;
			var strPos;
		
		 	arrParam[0] = order_cd;
	
			strURL = "<%=dirPath%>/Pms/new/bid/bid031.jsp";
		
			strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:no";
		
			arrResult = showModalDialog(strURL,arrParam,strPos);
		
			fnSelect();
			
 </script> 


<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">

</script>


<script language=JavaScript for=tr1 event=OnFail()>

alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
    
        msgTxt.innerHTML="데이타 조회중입니다..잠시만 기다려 주십시오.";
        
    </script>
 
 	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
 	
        msgTxt.innerHTML="조회가 완료 되었습니다.";

	</script> 

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_report classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

</head>


<!-- //body_s.jsp -->
<jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->

<!--------------------------------- 코딩 부분 시작 ------------------------------>     
<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
			     		<td align=right>
							<img src="<%=dirPath%>/Sales/images/refer.gif"				style="cursor:pointer" onclick="fnSelect()">
        					<img src="<%=dirPath%>/Sales/images/new.gif"				style="cursor:pointer" onClick="fnAdd()" >
        					<img src="<%=dirPath%>/Sales/images/print.gif"				style="cursor:pointer" onClick="fnPrint()" >        					
                        </td>								
                    </tr>
                </table>
            </td>
        </tr>
	<tr><td height=4></td></tr>
</table>
        
        
<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>		
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>
                        <td align=left class="text"  width="100">수주일</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>&nbsp;~&nbsp;
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
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
                        <td align="left" class="text" width="90">수주명</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                             <input type="text" name='v_order' id="v_order" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
                        </td>                         	
					</tr>
           		</table>
            </td>	
		</tr>
	

		<tr>
		 <td height=10>&nbsp;
		 </td>
		</tr>
        
        <tr>
            <td valign="top">
                <object id="gr_default" classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='600px' border='1'>
                    <param name="DataID"            	value="ds_default">
                    <param name="ColSizing"         	value="true">
                    <param name="Editable"          	value="false">
                    <param name="ComboDataID"      		value="ds_gc_ccstat">
                    <param name="SuppressOption"    	value="1">
                    <param name="BorderStyle"       	value="0">
                    <param name=ColSelect    			value="True">
                    <param name="Format"            	value="
	                     <C> name='NO' 				ID='{CurRow}'	   	width=30 		align=CENTER		</C>
                      <G>name='프로젝트'
                         <C> name='코드' 			ID='ORDER_CD'    	width=80 		align=CENTER 		mask='XXXXXXX-XXX'</C>
                         <C> name='프로젝트명' 		ID='ORDER_NM'   	width=250 		align=LEFT			</C> 
                      </G>
                         <C> name='발주처' 			ID='COMPANY_NM'   	width=100 		align=LEFT			</C>
                         <C> name='계약금액' 		ID='CONTRACT_AMT'   width=90 		align=RIGHT			DEC=0</C> 
                         <C> name='실행금액' 		ID='EXECUTE_AMT'   	width=90 		align=RIGHT			DEC=0</C>         
                         <C> name='매출이익' 		ID='SALES_PROFIT'   width=90 		align=RIGHT			DEC=0</C>  
                         <C> name='이익률' 			ID='PROFIT_RATE'    width=90 		align=RIGHT			DEC=2</C>  
                         <C> name='수주일' 			ID='ORDER_DT'    	width=100 		align=CENTER 		mask='XXXX-XX-XX'</C> 
                         <C> name='등록자'   		ID='NM_INSERT'   	width=60 		align=CENTER	 	</C>                                
                 ">                             
                </object>   
 		    </td>
        </tr>

    </table>
    







<%
/*=============================================================================
			레포트 선언
=============================================================================*/
%>



<object id=ReportID classid=<%=HDConstant.MxReport_CLSID_S%>> 
		<param name="MasterDataID"			value="ds_report">
		<param name="DetailDataID"			value="ds_report">
		<param name="PaperSize"				value="A4">
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">		
		<param name="Format"				value="
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=2754 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=79 ,top=2495 ,right=1881 ,bottom=2495 </L>
	<L> left=79 ,top=418 ,right=1881 ,bottom=418 </L>
	<L> left=79 ,top=339 ,right=1881 ,bottom=339 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 ,supplevel=1 </L>
	<T>id='보존기간' ,left=1087 ,top=355 ,right=1278 ,bottom=410 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='http://ace.hdasan.com/images/approval/2014ci.gif' ,left=1442 ,top=2638 ,right=1868 ,bottom=2709</I>
	<T>id='별 첨 : 실행 내역서 1부 /끝/' ,left=130 ,top=2138 ,right=1172 ,bottom=2193 ,align='left' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=79 ,top=2265 ,right=1881 ,bottom=2265 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='검 토' ,left=796 ,top=2278 ,right=982 ,bottom=2320 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확 인' ,left=1193 ,top=2278 ,right=1378 ,bottom=2320 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='승 인' ,left=1622 ,top=2275 ,right=1807 ,bottom=2318 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담 당' ,left=413 ,top=2275 ,right=598 ,bottom=2318 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=333 ,top=2328 ,right=1884 ,bottom=2328 </L>
	<L> left=331 ,top=2265 ,right=331 ,bottom=2614 </L>
	<L> left=691 ,top=2265 ,right=691 ,bottom=2617 </L>
	<L> left=1077 ,top=2265 ,right=1077 ,bottom=2619 </L>
	<L> left=1500 ,top=2265 ,right=1500 ,bottom=2619 </L>
	<L> left=82 ,top=2619 ,right=1884 ,bottom=2619 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='날 짜' ,left=132 ,top=2566 ,right=318 ,bottom=2609 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=79 ,top=2559 ,right=1881 ,bottom=2559 </L>
	<T>id='/' ,left=407 ,top=2508 ,right=593 ,bottom=2551 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=796 ,top=2508 ,right=982 ,bottom=2551 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=1204 ,top=2508 ,right=1389 ,bottom=2551 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=1619 ,top=2508 ,right=1804 ,bottom=2551 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='직위/성명' ,left=127 ,top=2508 ,right=312 ,bottom=2551 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결 재' ,left=130 ,top=2376 ,right=315 ,bottom=2432 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=74 ,top=593 ,right=1876 ,bottom=593 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 ,supplevel=1 </L>
	<C>id='ORDER_NM', left=537, top=524, right=1442, bottom=579, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0 ,CRFlag=true</C>
	<T>id='수주품의 -' ,left=331 ,top=524 ,right=527 ,bottom=579 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=307 ,top=339 ,right=307 ,bottom=590 </L>
	<T>id='제목' ,left=71 ,top=521 ,right=275 ,bottom=577 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=71 ,top=508 ,right=1873 ,bottom=508 </L>
	<T>id='문서번호' ,left=74 ,top=352 ,right=291 ,bottom=407 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1061 ,top=341 ,right=1061 ,bottom=508 </L>
	<L> left=1289 ,top=339 ,right=1289 ,bottom=505 </L>
	<T>id='기안자' ,left=1090 ,top=439 ,right=1278 ,bottom=495 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='PERSON', left=1312, top=439, right=1847, bottom=495, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DEPT_NM', left=331, top=439, right=1048, bottom=495, face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='기안부서' ,left=69 ,top=437 ,right=283 ,bottom=495 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<I>id='http://ace.hdasan.com/images/approval/2015slg.jpg' ,left=71 ,top=159 ,right=556 ,bottom=315</I>
	<L> left=1148 ,top=1741 ,right=1148 ,bottom=1879 </L>
	<T>id='매출 이익' ,left=114 ,top=1781 ,right=304 ,bottom=1836 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='내 용' ,left=868 ,top=794 ,right=1053 ,bottom=849 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\\' ,left=376 ,top=1648 ,right=445 ,bottom=1704 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\\' ,left=376 ,top=1778 ,right=445 ,bottom=1834 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='\\' ,left=376 ,top=1505 ,right=445 ,bottom=1561 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='VAT 불포함' ,left=1585 ,top=1503 ,right=1873 ,bottom=1558 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='VAT 불포함' ,left=1580 ,top=1646 ,right=1868 ,bottom=1701 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='기 타' ,left=114 ,top=1913 ,right=304 ,bottom=1974 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='비 고' ,left=1643 ,top=799 ,right=1828 ,bottom=855 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='이익율' ,left=968 ,top=1778 ,right=1132 ,bottom=1834 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='실행 금액' ,left=114 ,top=1646 ,right=304 ,bottom=1701 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계약 금액' ,left=114 ,top=1505 ,right=304 ,bottom=1561 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='발 주 처' ,left=114 ,top=1334 ,right=304 ,bottom=1389 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='수행 기간' ,left=114 ,top=1204 ,right=304 ,bottom=1259 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='주요 과제' ,left=114 ,top=1066 ,right=304 ,bottom=1122 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='프로젝트명' ,left=114 ,top=918 ,right=304 ,bottom=974 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='구 분' ,left=111 ,top=802 ,right=296 ,bottom=857 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='■ 프로젝트 개요' ,left=74 ,top=693 ,right=418 ,bottom=749 ,face='굴림' ,size=11 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COMPANY_NM', left=400, top=1344, right=1315, bottom=1400, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PROFIT_RATE', left=1177, top=1786, right=1529, bottom=1842, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ORDER_NM', left=400, top=918, right=1315, bottom=974, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CONTENT', left=400, top=1069, right=1315, bottom=1124, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PERIOD', left=400, top=1204, right=1315, bottom=1259, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='EXECUTE_AMT', left=466, top=1648, right=1146, bottom=1704, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='SALES_PROFIT', left=466, top=1778, right=881, bottom=1834, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='CONTRACT_AMT', left=466, top=1505, right=1148, bottom=1561, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<C>id='REMARK', left=400, top=1916, right=1315, bottom=1971, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1548 ,top=770 ,right=1548 ,bottom=2008 </L>
	<L> left=947 ,top=1741 ,right=947 ,bottom=1876 </L>
	<L> left=331 ,top=770 ,right=331 ,bottom=2008 </L>
	<L> left=79 ,top=1741 ,right=1881 ,bottom=1741 </L>
	<L> left=79 ,top=870 ,right=1881 ,bottom=870 </L>
	<L> left=79 ,top=1154 ,right=1881 ,bottom=1154 </L>
	<L> left=79 ,top=1876 ,right=1881 ,bottom=1876 </L>
	<L> left=79 ,top=1455 ,right=1881 ,bottom=1455 </L>
	<L> left=79 ,top=770 ,right=1881 ,bottom=770 </L>
	<L> left=79 ,top=1013 ,right=1881 ,bottom=1013 </L>
	<L> left=79 ,top=1289 ,right=1881 ,bottom=1289 </L>
	<L> left=79 ,top=1447 ,right=1881 ,bottom=1447 </L>
	<L> left=79 ,top=1601 ,right=1881 ,bottom=1601 </L>
	<L> left=79 ,top=2008 ,right=1881 ,bottom=2008 </L>
	<I>id='http://ace.hdasan.com/images/approval/approval.jpg' ,left=802 ,top=193 ,right=1199 ,bottom=323</I>
</B>




">
</object>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		



