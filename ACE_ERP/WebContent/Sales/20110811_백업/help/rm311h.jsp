<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
/******************************************************************************
 * 시스템명         : 가상계좌
 * 프로그램ID   : AC320H
 * J  S  P      : AC320H
 * 서 블 릿        : AC320H
 * 작 성 자        : 이병욱
 * 작 성 일        : 2006-08-17
 * 기능정의     : 
 * 수정내용     : 
 * 수 정 자        : 
 * 최종수정일자 :  
 *****************************************************************************/
%>
<%@ page import="sales.common.*"%>
<%
    // ContextPath
    String dirPath = request.getContextPath();
    
    
     String sSaup_sid = HDUtil.nullCheckStr(request.getParameter("sSaup_sid"));
     String sUpjang_sid = HDUtil.nullCheckStr(request.getParameter("sUpjang_sid"));
     String sUseDate = HDUtil.nullCheckStr(request.getParameter("sUseDate"));
			          
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <title>객실요금 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</title>
        <jsp:include page="/Sales/common/include/head.jsp"/>
<%
    /***************************************************************************
     *                            사용자 정의 Java Script                       *
     ***************************************************************************/
%>
        <script language="javascript">
            div='';
            function fnOnLoad() {
            cfStyleGrid(getObjectFirst("gr1"), "comn");
	              var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	              		+",dsType=1"
				          + ",sSaup_sid=<%=sSaup_sid%>"
				          + ",sUpjang_sid=<%=sUpjang_sid%>"
			             + ",sUseDate=<%=sUseDate%>";
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm311H",
				    "JSP(O:DS020=ds1)",
				    param);
				   
				tr_post(tr1);

		        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm311S",
		            "JSP(O:DS3=ds3)",
		            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
		        tr_post(tr1);	
            }
            
            
            function fnClose() {
            	window.close();
            }
            
            function fnSelect(){
            	 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	              		+",dsType=1"
				          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
				          + ",sUpjang_sid="+ lc2.ValueOfIndex("upjang_sid", lc2.Index)
			             + ",sUseDate="+sBgnDate.Text;
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm311H",
				    "JSP(O:DS020=ds1)",
				    param);
				   
				tr_post(tr1);
            }
            /*
	 * 영업장 조회
	 */		
	function fnSelectDs4() {
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds3.namevalue(ds3.rowposition,"saup_sid");	
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm311S",
            "JSP(O:DS4=ds4)",
            param);
        tr_post(tr2);
	}	 
            	/*
		 * 엑셀
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0){
	            alert("데이터를 먼저 조회하시길 바랍니다.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:객실요금; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("객실요금","객실요금.xls", 8);
		}
        </script>
        
<%
/*=============================================================================
            Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회중 
%>  
        <script language=JavaScript  for=ds1 event="OnLoadStarted()" >
            document.all.LowerFrame.style.visibility="visible"; 
        </script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회완료 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
            document.all.LowerFrame.style.visibility="hidden";
            if(row==0){
                alert("<%=HDConstant.S_MSG_NO_DATA%>");
                window.close();
            }
        </script>
        
        <script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs4();
				
		</script>
		<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
		fnSelectDs4(); 
		lc1.Index=lc1.IndexOfColumn("saup_sid",<%=sSaup_sid%>);
		lc2.Index=lc2.IndexOfColumn("upjang_sid",<%=sUpjang_sid%>);
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  DataSet 1 번 조회 메세지 처리 (플레쉬) 
//              :  조회오류 
%>          
        <script language=JavaScript  for=ds1 event="OnLoadError()">
            ft_cnt1.innerText="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
            document.all.LowerFrame.style.visibility="hidden";
        </script>



<%=HDConstant.COMMENT_START%>       
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object  id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object  id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>


    </head> 
    
<!--  BODY START -->
        <body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">
        <table>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan=2 height=25>
                                <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <span id=v_title>객실요금</span></td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table border="0" cellpadding="0" cellspacing="0" width="760px">
                        <tr>
                            <td align=right><img src="<%=dirPath%>/Sales/images/refer.gif"	style="cursor:hand"	align=absmiddle onClick="fnSelect()">
                            	<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()"><img name="btn_close" border="0" src="<%=dirPath%>/Sales/images/p_exit.gif" style="position:relative;left:5px;top:0px;cursor:hand;" align=absmiddle onClick="fnClose()">  
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:4px;top:10px">
        	<tr>
        		<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
	        	 <tr bgcolor="#6f7f8d">
					<td align=left width=70 class="text">&nbsp;<b>출발일자</b></td>
	                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
				     <comment id="__NSID__"><object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
						<param name=Text 		value="<%=sUseDate%>">
						<param name=Alignment 	value=1>
						<param name=Format 		value="0000-00-00">
						<param name=Cursor	 	value="iBeam">
						<param name=Border	 	value="0">		
						<param name=InheritColor      value="true">																																																				
						<param name=ReadOnly  	value="false">
						<param name=SelectAll   value="true">																				
						<param name=SelectAllOnClick   value="true">	
						<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																														
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
					</td>
					<td align=left width=70 class="text">&nbsp;지역</td>
	                <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                    <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=ds3>
							<param name=BindColumn      value="saup_sid">
	                        <param name=BindColVal      value="saup_sid">
							<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
							<param name=ListExprFormat  value="saup_nm^0^120"></object>
						<%=HDConstant.COMMENT_END%>
					</td>																				
					<td align=left width=70 class="text">&nbsp;호텔명</td>
	                <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                    <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=ds4>
							<param name=BindColumn      value="upjang_sid">
	                        <param name=BindColVal      value="upjang_sid">
							<param name=EditExprFormat	value="%,%;upjang_sid,upjang_nm">
							<param name=ListExprFormat  value="upjang_nm^0^120"></object>
						<%=HDConstant.COMMENT_END%>
					</td>
					</tr>
					</table>
				</tr>
                </td>
                <tr height=30>
                	<td>
                
<%
/*---------------------------------------------------------------------------->
    Object ID   : 그리드 , gr1
    Data ID     : ds1
-----------------------------------------------------------------------------*/
%>
                    	<%=HDConstant.COMMENT_START%>
																	<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:180" border="1" >
								                            			<param name="DataID"		VALUE="ds1">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="true">
								                            			<param name=UsingOneClick  	value="1">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name=MultiRowSelect    value=true>	
																		<param name=SuppressOption value=1>																			
																		<param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='', TextColor='Black'</SC>
																																	<SC>Type='EditCol', BgColor='', TextColor='Black'</SC>
																																	<SC>Type='FocusEditRow', BgColor='', TextColor='Black'</SC>
																																	<SC>Type='EditRow', BgColor='', TextColor='Black'</SC>
																																	<SC>Type='FocusCurCol', BgColor='', TextColor='Black'</SC>
																																	<SC>Type='CurCol', BgColor='', TextColor='Black'</SC>
																																	<SC>Type='FocusCurRow', BgColor='', TextColor='Black'</SC>
																																	<SC>Type='CurRow', BgColor='', TextColor='Black'</SC>
																																	<SC>Type='FocusSelRow', BgColor='', TextColor='Black'</SC>
																																	<SC>Type='SelRow', BgColor='', TextColor='Black'</SC>
																																	">								                                        																																                                        								                                        
																		<param name="Format" 			value="
															                <C> name='출발일'     ID='use_date'  bgColor={IF(select_div='Y','#E0CFE4','#fefec0')}fontstyle=bold  width=80  align=left editlimit=8 edit=none show=true mask=XXXX-XX-XX suppress=2</C>
															                <C> name='요일'      ID='yoil_nm'     bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} width=30 align=center editlimit=10 edit=none show=true suppress=3</C>
															                <C> name='객실' ID='room_type_cd'        bgColor={IF(select_div='Y','#E0CFE4','#fefec0')} width=140 align=left editlimit=5 edit=none show=true suppress=4</C>
															                <C> name='가용YN2'      ID='use_yn2'     width=40 align=left editlimit=1 edit=none show=false</C>
															                <C> name='가용YN1'      ID='use_yn1'     width=40 align=left editlimit=1 edit=none show=false</C>
															                <G> name='성인'
																                <C> name='2박' ID='n2_amt1'        bgColor=#fefec0 width=70 align=right editlimit=11 edit=none show=true dec=0</C>
																                <C> name='1박' ID='n1_amt1'        bgColor=#fefec0 width=70 align=right editlimit=11 edit=none show=true dec=0</C>																                
															                </G>
															                <G> name='대학'															                
																                <C> name='2박' ID='n2_amt2'     bgColor=#fefec0  width=70   align=right editlimit=11 edit=none show=true dec=0</C>
																                <C> name='1박' ID='n1_amt2'     bgColor=#fefec0  width=70   align=right editlimit=11 edit=none show=true dec=0</C>
															                </G>															                
															                <G> name='중고'															                															                
																                <C> name='2박' ID='n2_amt3'    bgColor=#fefec0   width=70  align=right editlimit=11 edit=none show=true dec=0</C>
																                <C> name='1박' ID='n1_amt3'    bgColor=#fefec0   width=70  align=right editlimit=11 edit=none show=true dec=0</C>
															                </G>															                
															                <G> name='초등'															                															                															                
																                <C> name='2박' ID='n2_amt4'    bgColor=#fefec0   width=70  align=right editlimit=11 edit=none show=true dec=0</C>
																                <C> name='1박' ID='n1_amt4'    bgColor=#fefec0   width=70  align=right editlimit=11 edit=none show=true dec=0</C>															                
															                <G> name='아동'															                															                															                															                
																                <C> name='2박' ID='n2_amt5'   bgColor=#fefec0   width=70   align=right editlimit=11 edit=none show=true dec=0</C>
																                <C> name='1박' ID='n1_amt5'   bgColor=#fefec0   width=70   align=right editlimit=11 edit=none show=true dec=0</C>															                
															                <G> name='유아'															                															                															                															                
																                <C> name='2박' ID='n2_amt6'  bgColor=#fefec0     width=70  align=right editlimit=11 edit=none show=true dec=0</C>
																                <C> name='1박' ID='n1_amt6'  bgColor=#fefec0     width=70  align=right editlimit=11 edit=none show=true dec=0</C>															                
															                <C> name='업장SID'   ID='upjang_sid'  align=left editlimit=12 edit=none show=false</C>
															                <C> name='객실타입SID'        ID='room_type_sid'       align=left editlimit=12 edit=none show=false</C>
															                <C> name='선택여부'     ID='select_div'   Width=60  align=center edit=none show=false </C> 																                																																																																					                
																		">
																	</object>
																	<%=HDConstant.COMMENT_END%> 
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset id=ft_div1 style="width:480;height:15px;border:0 solid #708090;text-align:left;">
                    &nbsp;<font id=ft_cnt1 style="position:relative;top:0px;">Cnt : </font>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td>
                <!--  상태바 플레쉬  -->
            <iframe id="LowerFrame" 
                name="work" 
                style="visibility:hidden; position:absolute; left:100px; top:150px;" 
                Frameborder="0" src="<%=dirPath%>/Sales/common/img/flash/loading.swf" 
                width="320px" 
                height="42px">
            </iframe>   
            </td>
            </tr>
        </table>
    </body>
    <!-- BODY END -->
</html>