<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - �ý��۸� 	     : �ⳳ ��Ȳ ��
 - ���α׷�ID 	 : PMS/SI025S
 - J  S  P		     : si020s.jsp
 - �� �� ��		 : Si010I
 - �� �� ��		 : ������
 - �� �� ��		 : 2012-07-19
 - �������		 : 
 - [ �������� ][������] ����
 - [2012-06-04][������] �ű�
 =============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>

<script language="javascript">
	var v_default_row = 1;
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");  //grid ���� 
		fnInit();	
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {

	    v_job ="I";
        ds_ingb_cd_0.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI001&s_item1=Y";
        ds_ingb_cd_0.Reset();  //�Է±��� 
        
        vt_fr_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        vt_fr_inout_dt.Text = vt_fr_inout_dt.Text .substring(0,6)+"01";
        vt_to_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";

        //vt_fr_inout_dt.Text = "20120401";
        //vt_to_inout_dt.Text = "20120430";
        
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si020I1",
            "JSP(O:DS_DEFAULT=ds_default)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
             tr_post(tr1);      
    }
    
    
    <%//���� ��ȸ  %>
    function fnSelect() {
    
        var fr_date = vt_fr_inout_dt.Text.trim();
        var to_date = vt_to_inout_dt.Text.trim();
    
       
       if(v_cost_cd_0.value==""){
       		alert("������ �ʼ��׸��Դϴ�.");
       		return false;
       }
       
       if( fr_date.substring(0,6)!= to_date.substring(0,6) ){
       		alert("��ȸ�� �ⳳ����� �����ؾ� �մϴ�. ");
       		return false;
       }
       
	    v_job="S";
	        

        if(fr_date.length!=8) {
            alert("�������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
            return;
        }
        
        if(to_date.length!=8) {
            alert("�������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
            return;
    	}
    	
       var strbeyymm = fr_date.substring(0,6);	
       var strYYYY=fr_date.substring(0,4);
	   var strMM=fr_date.substring(4,6);
	   var stryyyymm="";
	     
	   
	   //������ ��������  ( ������ �̺���  �������� �ܻ���Ա�����  �����ö� �ʿ��� ) 
   		if(strMM=="01"){
   			strYYYY=Number(strYYYY)-1;
   			strMM = "12";
   		}else{
   			strMM =String(Number(strMM)-1);			
   			if(strMM.length==1){
   				strMM = "0"+strMM;
   			}
   		}
	   
	   stryyyymm = strYYYY+strMM;
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                         + ",v_cost_cd=" + v_cost_cd_0.value
                         + ",v_ingb_cd=" + lc_ingb_cd_0.bindcolval
                         + ",v_fr_inout_dt =" + fr_date
                         + ",v_to_inout_dt =" + to_date 
                         + ",v_empno =6070001" 
                         + ",v_beyymm ="+strbeyymm   // �ⳳ���  
                         + ",v_pryymm ="+stryyyymm ;  // �̺ҳ��
                 
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si020I1",
            "JSP(O:DS_DEFAULT=ds_default)",
            param);
           // prompt('',param);
        tr_post(tr1);
    }    

    
    <%//���� ��- ��ȸ%>
    function fnSelCostPop_0(dirPath) {
        var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCostPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_cost_nm_0.value = arrParam[1];	//NM
            v_cost_cd_0.value = arrParam[0];	//SID
        } else {
			fnSelCostCleanup_0();
        }               
    }
    
     <%//���%>
    function fnPrint() {
    
          //DataSet Head ���� 
          gs_rpt_mst.clearAll();

		  var s_temp = "TITLE:STRING,COST_NM:STRING,USRNAME:STRING,USEDATE:STRING";
		  gs_rpt_mst.SetDataHeader(s_temp);

		  
		  gs_rpt_mst.addrow();
		  
		  var stryyyy=vt_fr_inout_dt.text.substring(0,4);
		  var strmm = vt_fr_inout_dt.text.substring(4,6);
		  
		  if(lc_ingb_cd_0.bindcolval=='4'){
		  	gs_rpt_mst.namevalue(gs_rpt_mst.rowposition,"TITLE") = stryyyy+"�� "+strmm+"�� "+ lc_ingb_cd_0.text+" ����";
		  }else{
		  	gs_rpt_mst.namevalue(gs_rpt_mst.rowposition,"TITLE") = stryyyy+"�� "+strmm+"�� "+ lc_ingb_cd_0.text+" ��볻��(�ܾ�)";
		  }
		  
		  gs_rpt_mst.namevalue(gs_rpt_mst.rowposition,"COST_NM")= "�����ڵ�:"+ds_default.namevalue(1,"COST_NM");
		  gs_rpt_mst.namevalue(gs_rpt_mst.rowposition,"USRNAME")= gusrnm;
		  gs_rpt_mst.namevalue(gs_rpt_mst.rowposition,"USEDATE")= "<%=DateUtil.getCurrentDate(8)%>"+ "<%=DateUtil.getCurrentTimeString()%>";
		  
          
          //Data��ȸ 
          gcrp_print.Preview();
 
    }
    
    function fnExcel(){
    	if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:�ⳳ��Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("�ⳳ��Ȳ", "�ⳳ��Ȳ.xls", 9); 
    }
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

    
     	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
	}
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
    
   
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
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}
			
			gr_default.ColumnProp('INOUT_DT','BgColor')= "FFCC66";
		}
		
		
		var  intJanamt=0;
		for(var i=1;i<=ds_default.countrow;i++){		
			ds_default.namevalue(i,"JANAMT")= Number(intJanamt) + Number(ds_default.namevalue(i,"INAMT"))-Number(ds_default.namevalue(i,"OUTAMT"));
			intJanamt = ds_default.namevalue(i,"JANAMT"); 
		}
				
	</script>
	
	 <script language=javascript for="ds_ingb_cd_0" event="OnLoadCompleted(row)">
	   
		for(var i =1 ;i<=row ;i++){
      		if(ds_ingb_cd_0.namevalue(i,"DETAIL")!=3){
      			ds_ingb_cd_0.RowMark(i)=1;
      		}
      	}
		ds_ingb_cd_0.DeleteMarked();
		
	</script>
	
	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��ȸ-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_ingb_cd_0 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �Է±���-->
    <param name="SyncLoad"  value="True">
</object>

<object id=gs_rpt_mst classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--��¹�-->
    <param name="SyncLoad"  value="True">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"     value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
                            <img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" onclick="fnPrint()">
                            <img src="<%=dirPath%>/Sales/images/excel.gif"      style="cursor:hand"  onclick="fnExcel()">
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
                                    <td align="center" class="text" width="70">����</td>                                                                     
                                    <td bgcolor="#FFFFFF" >&nbsp;
                                        <input type="text" name='v_cost_nm_0' id="v_cost_nm_0" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop_0('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_cost_cd_0' id='v_cost_cd_0'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostPop_0('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostCleanup_0();" alt="�� �����">
                                    </td>
                                    <td align="center" class="text" width="70">�Է±���</td>
                                    <td bgcolor="#FFFFFF">&nbsp;
                                       <%=HDConstant.COMMENT_START%>
			                            <object id=lc_ingb_cd_0 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150  width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_ingb_cd_0>
                                            <param name=BindColumn       value="detail">
                                            <param name=BindColVal         value="detail">
                                            <param name=EditExprFormat   value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat   value="detail_nm^0^100">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
                                    </td>
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">�ⳳ����</td>
			                        <td align=left bgcolor="#ffffff" colspan="3">&nbsp;&nbsp<%=HDConstant.COMMENT_START%>
			                            <object id=vt_fr_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
			                            <object id=vt_to_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
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
			           		</table>
			           	</td>
			     	</tr>
                 </table>
            </td>
        </tr> 
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="845px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='430px' border='1'>
                                <param name="DataID"                  value="ds_default">
                                <param name="ColSizing"              value="true">
                                <param name="Editable"                value="false">
                                <param name="BorderStyle"          value="0">
                                <param name="ViewSummary"      value="1">
                                <param name="Format"                 value="
                                     <C>Id=Count name='CurLevel' width=80 Align=Right  Value={CurLevel}  show =false</C>
                                     <C> name='�Է±���'	   ID='INGB_CD'    	         width=90 	align=CENTER	 editstyle=lookup Data='ds_ingb_cd_0:detail:detail_nm'   Value={Decode(CurLevel,2,'���� ��',0,INGB_CD)}   sumtext='��'</C>
                                     <C> name='����'            ID='ATKORNAM'       	     width=140 	align=left 		     sumtext='@cnt' sumtextalign='center'  Value={Decode(CurLevel,1,'������ �Ұ�',0,ATKORNAM)} </C>
                                     <C> name='����'	   	       ID='INOUT_DT' 		         width=69 	align=CENTER	 mask='XXXX/XX/XX'   sumtext='��'   sumtextalign='center'      BgColor={IF(CurLevel=0,'#FFFFFF','#FFCC66')} </C>
									 <C> name='�Ա�' 		   ID='INAMT'        	         width=80 	align=right    	 sumtext='{SUM(Number(INAMT))}'  Value={Number(INAMT)}  </C>
									 <C> name='���ް�' 		   ID='SUPAMT'    	         width=80 	align=right    	 sumtext='@sum'  </C>
                                     <C> name='�ΰ���'  	   ID='VATAMT'                   width=60 	align=right 		 sumtext='@sum'  </C>
                                     <C> name='��'    	       ID='OUTAMT'   	              width=80 	align=right 	     sumtext='@sum'  </C>
                                     <C> name='�ܾ�'    	       ID='JANAMT'   	              width=80 	align=right 	       </C>
                                     <C> name='����'   	       ID='REMARK'   	              width=180 	align=left   	    </C>
                                     <C> name='�ŷ�ó'    	   ID='VEND_NM'      	          width=120 	align=left  	    </C>
                                     <C> name='�ŷ�ó�ڵ�'   ID='VEND_CD'      	          width=60 	align=left  	    </C>
                                     <C> name='������'	       ID='OWNER_NM'              width=60 	align=center 	 show=false</C>
                                     <C> name='���'	           ID='PRT_CARD_NUM'      width=150 	align=left  	    </C>
                                     <C> name='���'	           ID='CARD_NUM'              width=125 	align=center 	 mask='XXXX-XXXX-XXXX-XXXX' show=false</C>
                                     <C> name='����' 		   ID='CSTR_NM'                width=120 	align=left       	 show=true</C>
                                     <C> name='�ڻ��ȣ'	   ID='H_ASTNBR'    	          width=80 	align=center 	 show=false</C>
                                     <C> name='�����ڵ�'	   ID='COST_CD'    	          width=80 	align=center 	 show=false</C>
                                     <C> name='������'	       ID='COST_NM'    	          width=80 	align=center 	 show=false</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>                      
                    </tr>
                </table>
			</td>
        </tr>
        
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        

    </table>

<%
/*=============================================================================
	Report 
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<OBJECT id=gcrp_print  classid=<%=HDConstant.CT_REPORT_CLSID%> VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gs_rpt_mst">
	<param name="DetailDataID"                value="ds_default"> 
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="1">
     <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<param name=NullRecordFlag			    value=false>
	<param name="SaveToFileShowButton"value="true">		
	<PARAM NAME="Format" VALUE="

<B>id=FHeader ,left=0,top=0 ,right=2871 ,bottom=262 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=2154 ,top=11 ,right=2365 ,bottom=77 ,border=true</X>
	<X>left=2154 ,top=196 ,right=2365 ,bottom=262 ,border=true</X>
	<X>left=2154 ,top=74 ,right=2365 ,bottom=198 ,border=true</X>
	<X>left=2363 ,top=11 ,right=2574 ,bottom=77 ,border=true</X>
	<X>left=1945 ,top=11 ,right=2156 ,bottom=77 ,border=true</X>
	<X>left=1945 ,top=196 ,right=2156 ,bottom=262 ,border=true</X>
	<X>left=2363 ,top=196 ,right=2574 ,bottom=262 ,border=true</X>
	<X>left=2572 ,top=11 ,right=2783 ,bottom=77 ,border=true</X>
	<X>left=2572 ,top=196 ,right=2783 ,bottom=262 ,border=true</X>
	<T>id='��  ��' ,left=1958 ,top=19 ,right=2143 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=2167 ,top=19 ,right=2352 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ȯ  ��' ,left=2376 ,top=19 ,right=2561 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=2588 ,top=19 ,right=2773 ,bottom=69 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=1958 ,top=204 ,right=2143 ,bottom=254 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=2164 ,top=204 ,right=2350 ,bottom=254 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=2381 ,top=204 ,right=2566 ,bottom=254 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='/' ,left=2588 ,top=204 ,right=2773 ,bottom=254 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=2363 ,top=74 ,right=2574 ,bottom=198 ,border=true</X>
	<X>left=2572 ,top=74 ,right=2783 ,bottom=198 ,border=true</X>
	<X>left=1945 ,top=74 ,right=2156 ,bottom=198 ,border=true</X>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=257 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='����' ,left=611 ,top=201 ,right=1257 ,bottom=251 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2357 ,top=198 ,right=2357 ,bottom=254 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=198 ,right=2122 ,bottom=254 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1908 ,top=198 ,right=1908 ,bottom=254 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1709 ,top=198 ,right=1709 ,bottom=254 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=609 ,top=198 ,right=609 ,bottom=254 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=418 ,top=198 ,right=418 ,bottom=254 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<T>id='��������' ,left=40 ,top=201 ,right=418 ,bottom=251 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ΰ���' ,left=1715 ,top=201 ,right=1908 ,bottom=251 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�հ�' ,left=1913 ,top=201 ,right=2119 ,bottom=251 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=34 ,top=196 ,right=2783 ,bottom=196 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='����' ,left=423 ,top=201 ,right=606 ,bottom=251 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=37 ,top=257 ,right=2786 ,bottom=257 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
	<T>id='�Ա�' ,left=1267 ,top=201 ,right=1490 ,bottom=251 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ŷ�ó' ,left=2365 ,top=201 ,right=2781 ,bottom=251 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ܾ�' ,left=2127 ,top=201 ,right=2350 ,bottom=251 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1498 ,top=196 ,right=1498 ,bottom=251 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1257 ,top=198 ,right=1257 ,bottom=251 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='COST_NM', left=42, top=138, right=1254, bottom=185, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<T>id='���ް�' ,left=1503 ,top=201 ,right=1709 ,bottom=251 ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TITLE', left=799, top=3, right=1902, bottom=90, face='����', size=18, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=56 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=609 ,top=0 ,right=609 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,2,\'�հ�\',ATKORNAM)}', left=40, top=0, right=418, bottom=48, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUPAMT', left=1503, top=0, right=1709, bottom=48, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VATAMT', left=1715, top=0, right=1908, bottom=48, align='right' ,mask='XXXX-XX-XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='SUMAMT', left=1913, top=0, right=2119, bottom=48, align='right' ,mask='XXXX-XX-XX', face='Tahoma', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=37 ,top=53 ,right=2786 ,bottom=53 </L>
	<L> left=418 ,top=3 ,right=418 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1709 ,top=3 ,right=1709 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1908 ,top=3 ,right=1908 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=0 ,right=2122 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2357 ,top=0 ,right=2357 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1257 ,top=0 ,right=1257 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='{decode(curlevel,1,\'�Ұ�\',INOUT_DT)}', left=423, top=0, right=606, bottom=48 ,mask='XXXX-XX-XX', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=611, top=0, right=1257, bottom=48, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VEND_NM', left=2365, top=0, right=2781, bottom=48, align='left', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1498 ,top=0 ,right=1498 ,bottom=56 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<C>id='JANAMT', left=2127, top=0, right=2350, bottom=48, align='right', face='Tahoma', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='INAMT', left=1273, top=0, right=1495, bottom=48, align='right', face='Tahoma', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Tail ,left=0,top=0 ,right=2871 ,bottom=56 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=37 ,top=56 ,right=2786 ,bottom=56 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<S>id='{Sum(SUPAMT)}' ,left=1503 ,top=3 ,right=1709 ,bottom=50 ,align='right' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(VATAMT)}' ,left=1715 ,top=3 ,right=1908 ,bottom=50 ,align='right' ,face='Tahoma' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<S>id='{Sum(SUMAMT)}' ,left=1913 ,top=3 ,right=2119 ,bottom=50 ,align='right' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<T>id='�հ�' ,left=611 ,top=3 ,right=1257 ,bottom=53 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(INAMT)}' ,left=1273 ,top=3 ,right=1495 ,bottom=50 ,align='right' ,face='Tahoma' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</S>
	<L> left=1257 ,top=3 ,right=1257 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1498 ,top=3 ,right=1498 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1709 ,top=3 ,right=1709 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=1908 ,top=3 ,right=1908 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
	<L> left=2122 ,top=3 ,right=2122 ,bottom=53 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=1894 ,right=2871 ,bottom=2000 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=37 ,top=0 ,right=2786 ,bottom=0 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='�� �� �� :' ,left=37 ,top=5 ,right=206 ,bottom=53 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='USRNAME', left=204, top=5, right=410, bottom=53, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�������:' ,left=37 ,top=56 ,right=206 ,bottom=103 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='USEDATE', left=206, top=56, right=929, bottom=103, align='left' ,mask='XXXX.XX.XX XX:XX:XX', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='Page : #p of #t' ,left=1267 ,top=34 ,right=1905 ,bottom=82 ,align='left', MargineX=3</T>
	<I>id='../../Common/img/icon.jpg' ,left=2363 ,top=21 ,right=2786 ,bottom=98</I>
</B>


	
	">
	<%=HDConstant.COMMENT_END%>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		