<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���ں� ��ǰ����
 * ���α׷�ID 	 : RM420B
 * J  S  P		 : rm420b
 * �� �� ��		 : RM420B
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-06-12
 * �������		 : ���ں� ��ǰ���� (��ȸ, ����)
 * �������		 : 
 * 				      
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}
	/*
	 * ����ȸ
	 */
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        //��ǰ����
        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds2.Reset();         
	}
	/*
	 * ������ȸ
	 */
    function fnSelect() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sGoodsSid=" + sGoodsSid.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm420B",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
    }
	/*
	 * ����
	 */
	function fnApply() {
        v_job = "I";	
		var checkDiv='';			
		if(ds1.IsUpdated) {
			for( i=1;i<=ds1.CountRow;i++ ) {
				if ( ds1.namevalue(i,"use_yn") == 'T' ) {
					checkDiv='true';
					break;
				}
			}		
			if ( checkDiv != 'true' ) { alert("��� �ϳ��� ����üũ�� �����ϼž� �մϴ�."); return; } 				
            window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_RM%>Rm420B",
                "JSP(I:DEFAULT=ds1)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
            tr_post(tr1);
		}
	}
	/*
	 * ���
	 */  
	function fnCancel() {
		ds1.undoall();
		window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
	}
	/*
	 *  �˾� 
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		strURL = "<%=dirPath%>/Sales/help/rm002h.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
	    	sGoodsSid.value = arrParam[0];
			sGoodsCd.value = arrParam[1];
			sGoodsNm.value = arrParam[2];					
		} else {
	    	sGoodsSid.value = 0;
			sGoodsCd.value = '';
			sGoodsNm.value = '';					
		}
	}	
	/*
	 * ��ǰ���� �ڵ�����(����)
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnSetting(dataSet) {   
		var exit=false;
		if ( dataSet == 'ds2' ) {	//��ǰ����
			for ( i=1; i<=ds2.CountRow; i++ ) {
				if ( ds2.namevalue(i,"goods_cd") == sGoodsCd.value ) {
					sGoodsSid.value = ds2.namevalue(i,"goods_sid");
					sGoodsNm.value = ds2.namevalue(i,"goods_nm");
					exit=true;
					return;
				}
			}
			if ( exit != true ) {
				sGoodsSid.value = 0;
				sGoodsNm.value = '';				
			}
		}		
	} 	
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
			if ( colid == 'use_yn' ) {
				if ( ds1.namevalue(row,"bgn_date") == '' ||  ds1.namevalue(row,"end_date") == '' )  {
					ds1.namevalue(row,"use_yn") = 'F';		
					alert("�������ڿ� �������ڸ� �Է��ϼž� �մϴ�.");
				}
			}
		</script>

		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			if ( colid == 'use_yn' ) {		
				if ( ds1.namevalue(row,"bgn_date") == '' ||  ds1.namevalue(row,"end_date") == '' )  {
					ds1.namevalue(row,"use_yn") = 'F';		
					alert("�������ڿ� �������ڸ� �Է��ϼž� �մϴ�.");
				}				
			}
		</script>
    
    <script language=JavaScript for=ds1 event=onColumnChanged(row,colid)>
        var flag = false;
        if(colid=="UPJANG_TYPE"){
            for(var i=1; i<=ds21.CountRow; i++){
                if(ds21.NameValue(i, "DETAIL")==ds1.NameValue(row, colid)){
                    ds1.NameValue(row, "UPJANG_TYPE_NM") = ds21.NameValue(i, "DETAIL_NM");
                    flag = true;
                    return;
                }
            }
            if(!flag)
                ds1.NameValue(row, "UPJANG_TYPE_NM") = "";
        }
    </script>

    <script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
        if(colid=="UPJANG_TYPE") {
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL;
            var strPos;
            //arrParam[0] : head
            //arrParam[1] : detail
            //arrParam[2] : detail_nm
            //arrParam[3] : item1
            arrParam[0] = "RM001";
            arrParam[1] = "����Ÿ��"; //�����ڵ��� �����Ͱ�
            strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            arrResult = showModalDialog(strURL,arrParam,strPos);
            if (arrResult != undefined) {
                arrParam = arrResult.split(";");
                ds1.namevalue(ds1.RowPosition,"UPJANG_TYPE")=arrParam[1];
                ds1.namevalue(ds1.RowPosition,"UPJANG_TYPE_NM")=arrParam[2];
            }
        }
    </script>
    
	<script language=JavaScript for=gr1 event=OnExit(row,colid,olddata)>
		if ( colid == 'end_date' ) 	//�������ڿ� ���������� ���� üũ
			if ( ds1.namevalue(row,"bgn_date") != '' ) {			
				if ( ds1.namevalue(row,"bgn_date") > ds1.namevalue(row,"end_date") ) {
					alert("�������ڰ� �������ں��� �۽��ϴ�. �ٽ� �Է��� �ּ���.");
					ds1.namevalue(row,"end_date") = '';
				}
			}
		if ( colid == 'bgn_date' ) 	//�������ڿ� ���������� ���� üũ
			if ( ds1.namevalue(row,"end_date") != '' ) {
				if ( ds1.namevalue(row,"bgn_date") > ds1.namevalue(row,"end_date") ) {
					alert("�������ڰ� �������ں��� �۽��ϴ�. �ٽ� �Է��� �ּ���.");
					ds1.namevalue(row,"bgn_date") = '';
				}				
			}			
	</script>	    
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";	
	</script>

	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	     window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds2 event="OnLoadStarted()">
	    window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
         window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!--  ��ǰ���� -->
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">		
						            			<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnSelect()">
						            			<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnApply()">
						            			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnCancel()">
								 			</td>
										</tr>																		
									</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>           
				
				<tr height="30px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left width=70 class="text">&nbsp;��ǰ�ڵ�</td>
			                                <td align=left bgcolor="#ffffff" width=780 colspan=7>&nbsp;																										
												<input id="sGoodsSid" type="hidden">                                
												<input id="sGoodsCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:70px; height:20px;" maxlength=7 onBlur="fnSetting('ds2')">
												<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="�ٹ������� �˻��մϴ�" style="cursor:pointer;position:relative;left:-0px;top:0px" align=center onclick="fnPopup();">
												<input id="sGoodsNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" readOnly>																						
											</td>	
					         			</tr>
			            			</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>																 
            	<tr>
            		<td height=10  border="0"></td>
            	</tr>
            	<tr>
                	<td valign=top colspan=2>
                	   <table border= "0" cellpadding=0 cellspacing=0 border=0>
                			<tr>
                				<td>
                            		<%=HDConstant.COMMENT_START%>
                            		<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845px; height:380px" border="1">
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                            			<param name="Format"		 VALUE="
                                            <FC> name=''             ID='{STRING(CURROW)}'           Width=25    align=center</FC>
                                            <FC> name='��ǰSID'    ID='goods_sid'          Width=70   align=center    BgColor=#fefec0 Edit=none editlimit=5 show=false</FC>                                            
                                            <FC> name='��ǰ�ڵ�'    ID='goods_cd'          Width=70   align=center    BgColor=#fefec0 Edit=none editlimit=5 Sort=True</FC>
                                            <FC> name='��ǰ��'     ID='goods_nm'          Width=200   align=left      BgColor=#fefec0 Edit=none Sort=True</FC>
                                            <C> name='����'          ID='use_yn'      Width=30   align=center      Editstyle=checkbox</C>
                                            <C> name='��������'          ID='bgn_date'    Width=70   align=center      Edit=Numeric	mask='XXXX-XX-XX'</C>
                                            <C> name='��������'     ID='end_date'        Width=70    align=center      Edit=Numeric mask='XXXX-XX-XX'</C>
                            			">
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
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

