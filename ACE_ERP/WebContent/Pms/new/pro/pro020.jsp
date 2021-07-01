<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>PMS>������Ʈ ����>������Ʈ��Ȳ
 * ���α׷�ID 	 : PMS/PRO020
 * J  S  P		 : pro020.jsp, GAUCE5.x
 * �� �� ��		 : Pr020
 * �� �� ��		 : �� �� ��
 * �� �� ��		 : 2018-06-21
 * [ �������� ][������] ����
 * [2018-06-21][�̵���] ��ü ������Ʈ ��Ȳ ��ȸ
 *						
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
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


<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>



<!-- HTML ���� : doctype�� html5��-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<meta charset=euc-kr">
    <!--  head.jsp -->
    <jsp:include page="/Pms/common/include/head.jsp"/>
    <!--  //head.jsp -->
    
	<!-- ÷�� ������ ���� -->
    <jsp:include page="../../common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->      
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">

	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	var menuWin;	//��â �����.
	
	var v_todt = "<%=DateUtil.getCurrentDate(8)%>";
	
	/*
	 * �������ε�
	 */
	 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
		cfStyleGrid(getObjectFirst("gr_default"), "comn");	//project list

		fnInit();
		
	}
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";
	    
        ds_gc_prop1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY201&s_item1=Y";
        ds_gc_prop1.Reset();	//���ͼ���
        
        
        ds_gc_prop2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SY202&s_item1=Y";
        ds_gc_prop2.Reset();	//�������

	    v_fr_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,4)+"01"%>";
        v_to_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)%>";			    
	    
        fnSelect();        
        
    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	
	    	v_job="S";

	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							+ ",v_project=" + v_project.value												//propject��        
				            + ",v_frdt=" + v_fr_date.text.substr(2,4)
				            + ",v_todt=" + v_to_date.text.substr(2,4)							
							+ ",v_prop1=" + lc_gc_prop1.ValueOfIndex("detail", lc_gc_prop1.Index)			//���ͼ���
							+ ",v_prop2=" + lc_gc_prop2.ValueOfIndex("detail", lc_gc_prop2.Index)			//�������
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

    
	<%//�׼� �ٿ��ϱ�%>
    function fnExcelDsDefault() {
    	
        if(ds_default.CountRow==0){
        	
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
            
        }
        
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        
        getObjectFirst("gr_default").SetExcelTitle(1, "value:�����ڵ� ��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        
        getObjectFirst("gr_default").GridToExcel("�����ڵ� ��Ȳ", "�����ڵ�_��Ȳ.xls", 8);        
        
    }

    
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//������ �׸��� OnClick %>
	<script language="javascript"  for=gr_default event=OnClick(Row,Colid)>
	

	</script>


    <script language=JavaScript for=ds_default event=OnRowPosChanged(row)>
    
        //�Է� ���ϰ� ����

        if(row > 0) {
            //��ϵ� ���ϵ� ��ȸ
            fnc_GetFileList(ds_default.NameValue(row, "FILE_KEY"));

        }
	</script>


	<!-- ���� �׸��� Ŭ���� �ٿ�ε� �ǰ� -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>

        if(row > 0) {

            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");

            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
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
		alert("���������� ����Ǿ����ϴ�.");
		fnSelect(); // �����ϵ� ��ȸ�ϱ�
	}
	
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

    
<%
/*=============================================================================
			DataSet Components(DS) ����
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


<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
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
                        <td align=left class="text"  width="100">�Ⱓ</td>
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
                
                
                
                        <td align="center" class="text" width="90">������Ʈ��</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_project' id="v_project" style="width:100px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="">
							<img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnProjectNoCleanup();" alt="�� �����">
                        </td>
                        

                        <td align="center" class="text" width="90">��з�</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_gc_prop1 classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=150 border="0"  align=absmiddle>
                                <param name=ComboDataID     	value=ds_gc_prop1>
								<param name=BindColumn      	value="detail">
								<param name=BindColVal      	value="detail">
								<param name=EditExprFormat  	value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  	value="detail_nm^0^150">
                            </object>
                        </td>
                        
                        <td align="center" class="text" width="90">�ߺз�</td>
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
                        <C> name='�ڵ�'		 		ID='COST_CD'    		width=80 	align=center 	edit=none </C>				
						<C> name='������Ʈ'   	 	ID='PLJ_NM'   	 		width=350 	align=left	 	edit=none </C>
						<C> name='��з�'   		ID='PROP1' 				width=80 	align=center	editstyle=lookup Data='ds_gc_prop1:detail:detail_nm' SumText=@count</C>
						<C> name='�ߺз�'   		ID='PROP2' 				width=80 	align=center	editstyle=lookup Data='ds_gc_prop2:detail:detail_nm' SumText='��'</C>

                        <C> name='�����'		 	ID='PL_DEPT_NM'			width=110 	align=center  	edit=none </C>
                        <C> name='������'	 		ID='CTRT_BGNDATE'  		width=70 	align=center 	show=false mask='XXXX-XX-XX'</C>
                        <C> name='������'	 		ID='CTRT_ENDDATE'  		width=70 	align=center 	show=false mask='XXXX-XX-XX'</C>
                        <C> name='����ó'	 		ID='ORDER_COMP_NM'  	width=100 	align=left   	edit=none </C>
                        <C> name='���־�'    		ID='WIN_FEE'	 		width=80 	align=right	 	decao=0  show=false</C>
                        <C> name='FILE_KEY'		 	ID='FILE_KEY'    		width=150 	align=center  	</C>
                        <C> name='���'			 	ID='USE_YN'    			width=40 	align=center 	show=false</C>
                        <C> name='������'	 		ID='WIN_DATE'  			width=70 	align=center 	mask='XXXX-XX-XX' show=false</C>
                        <C> name='����PM'			ID='PM_NM'   			width=70 	align=center 	show=false </C>
                        <C> name='����'      		ID='COST_FEE'	 		width=80 	align=right	 	show=false decao=0  </C>
                        <C> name='Ư�̻���'		 	ID='NOTE'   			width=70 	align=center 	show=false</C>
					">                             
                </object>                        
            </td>
        </tr>
        
		<tr height='6px'>
            <td></td>
        </tr>
        
        <tr>
            <td valign="top">
            <!-- �� ȭ�� -->        
                <table  border='0' cellpadding='0' cellspacing='0'>
					<tr>
						<td>&nbsp;
						</td>
					</tr>
					    
					<tr>
						<td>
						<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;�� ����÷��</font>
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
				                        <C> id=FILE_NAME    width="700"     name="���ϸ�"      align="left"    leftmargin="10"</C>
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
			Bind ����
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


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>





		