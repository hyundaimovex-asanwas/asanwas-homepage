<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : ����_ǰ��
 * ���α׷�ID 	 : PMS/PU070I
 * J  S  P		 	 : pu070i.jsp
 * �� �� ��		 : Pu070I
 * �� �� ��		 : �ڰ汹
 * �� �� ��		 : 2011-12-01
 * �������		 : ����_ǰ��
 * [ �������� ][������] ����
 * [2011-12-01][�ڰ汹] �ű�
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
	  //���ϸ���Ʈ html �����
	    StringBuffer sb = new StringBuffer();
		String real_fileList ="";	//���� �ҷ��ͼ� 
		String sys_fileList ="";
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
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		cfStyleGrid(getObjectFirst("gr_tender"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail"), "comn");
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	alert("fnInit()");

     }
    
    <%//���� ��ȸ  %>
    function fnSelect() {
    	alert("fnSelect()");
   
    }    

 
	
	/*
	 * ����Ʈ
	 */
	function fnPrint() {
		alert("fnPrint()");
        
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
<%=HDConstant.COMMENT_START%>
<object id=ds_default6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ--%>
<object id=ds_default7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ_����1--%>
<object id=ds_default8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ_����2--%>
<object id=ds_default9_1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ_����3--%>
<object id=ds_default9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ_����4--%>

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
<jsp:include page="/Common/sys/body_s08.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                     <tr>
                    	<td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:hand"  onclick="fnPrint()">		<!-- �μ� -->							
						</td>
                    </tr>
                </table>
            </td>
        </tr>
      </table>
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_default">
	             <param name=BindInfo    value="
					<C>Col=CON_STATUS     	 Ctrl=lc_con_status    	Param=BindColVal </C>
					<C>Col=CON_STATUS_NM     	 Ctrl=v_con_status_nm    	Param=value </C>
					<C>Col=RQST_DATE       	 Ctrl=v_rqst_date        	Param=Text </C>
					<C>Col=DATE_DDL       	 Ctrl=v_date_ddl         	Param=Text </C>					
					<C>Col=DATE_CON       	 Ctrl=v_date_con        	Param=Text </C>
					<C>Col=DATE_FR       	 	 Ctrl=v_date_fr  	     	Param=Text </C>
					<C>Col=DATE_TO       	 	 Ctrl=v_date_to        	 	Param=Text </C>
					<C>Col=RQST_NO       	 	 Ctrl=v_rqst_no        	 	Param=value </C>
					<C>Col=CON_NO       	 	 Ctrl=v_con_no        	 	Param=value </C>					
					<C>Col=RQST_SID	       	 Ctrl=v_rqst_sid 	     	Param=Value </C>
					<C>Col=CON_SID		       	 Ctrl=v_con_sid 	     	Param=Value </C>					
					<C>Col=EST_SID		       	 Ctrl=v_est_sid 	     	Param=Value </C>										
					<C>Col=RQST_USE     		 Ctrl=lc_rqst_use	     	Param=BindColVal </C>
					<C>Col=SITE_CD       	 	 Ctrl=v_pu_site_cd     	Param=value </C>
					<C>Col=PUT_WH     		 	 Ctrl=lc_put_wh	     	Param=BindColVal </C>
					<C>Col=TERMS_TRANS     Ctrl=lc_terms_trans  	Param=BindColVal </C>
					<C>Col=WAY_CHK     		 Ctrl=lc_way_chk	     	Param=BindColVal </C>
					<C>Col=TERMS_PAY     	 Ctrl=lc_terms_pay    	Param=BindColVal </C>
					<C>Col=BUR_TRANS     	 Ctrl=lc_bur_trans     	Param=BindColVal </C>
					<C>Col=OSV_PVR       	 	 Ctrl=v_osv_pvr		     	Param=value </C>
					<C>Col=CON_NOTE	       	 Ctrl=v_con_note	    	Param=Value </C>					
					<C>Col=SITE_NM       	 	 Ctrl=v_site_nm1        	Param=value </C>
					<C>Col=SITE_SID	       	 	 Ctrl=v_site_sid1 	     	Param=Value </C>
					<C>Col=PU_EMPNO    	 	 Ctrl=v_pu_empno   		Param=value </C>
					<C>Col=PREPAY_AMT_RATE    Ctrl=v_prepay_amt_rate   	Param=text </C>
					<C>Col=PREPAY_AMT    			Ctrl=v_prepay_amt   		Param=value </C>
					<C>Col=CH_RATE    	 	 			Ctrl=v_ch_rate   		Param=text </C>
					<C>Col=CH_AMT    	 	 			Ctrl=v_ch_amt   		Param=value </C>
					<C>Col=DB_RATE    	 	 			Ctrl=v_db_rate   		Param=text </C>
					<C>Col=DB_AMT    	 	 			Ctrl=v_db_amt   		Param=value </C>
					<C>Col=TERM_GRN    	 	 		Ctrl=v_term_grn   		Param=value </C>																				
					<C>Col=TOT_FN_EST_AMT  	 	 		Ctrl=v_tot_fn_est_amt		Param=value </C>		
					<C>Col=AP_DESC_RE 	 	 Ctrl=v_ap_desc_re   	 Param=value </C>											
					<C>Col=real_file	    	 	 Ctrl=txt_real_file		 	 	Param=value </C>
					<C>Col=sys_file	    	 	 Ctrl=txt_sys_file		 		Param=value </C>																						
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
		
<%
/*=============================================================================
			����Ʈ ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object id=pr1 classid=<%=HDConstant.CT_REPORT_CLSID%>> 
	<param NAME="MasterDataID"				VALUE=ds_default6>
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="0">
    <PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2101 ,bottom=881 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='* �⺻����' ,left=50 ,top=101 ,right=450 ,bottom=167 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<X>left=50 ,top=180 ,right=1950 ,bottom=881 ,border=true</X>
	<L> left=1601 ,top=180 ,right=1601 ,bottom=680 </L>
	<L> left=1352 ,top=180 ,right=1352 ,bottom=680 </L>
	<L> left=50 ,top=741 ,right=1950 ,bottom=741 </L>
	<L> left=50 ,top=450 ,right=1950 ,bottom=450 </L>
	<L> left=50 ,top=246 ,right=1950 ,bottom=246 </L>
	<L> left=50 ,top=312 ,right=1950 ,bottom=312 </L>
	<L> left=50 ,top=376 ,right=1950 ,bottom=376 </L>
	<L> left=50 ,top=601 ,right=1950 ,bottom=603 </L>
	<T>id='û����ȣ' ,left=56 ,top=185 ,right=286 ,bottom=241 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='��������' ,left=1357 ,top=185 ,right=1588 ,bottom=241 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='��ݺ�δ�' ,left=1357 ,top=251 ,right=1588 ,bottom=307 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='�����Ⱓ' ,left=1357 ,top=386 ,right=1588 ,bottom=442 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='���޾�ü' ,left=1357 ,top=315 ,right=1588 ,bottom=370 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='�����' ,left=1357 ,top=460 ,right=1588 ,bottom=516 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='û������' ,left=706 ,top=185 ,right=937 ,bottom=241 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='ǰ������' ,left=704 ,top=254 ,right=934 ,bottom=310 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='���ޱ���' ,left=704 ,top=315 ,right=934 ,bottom=370 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='��ຸ������' ,left=706 ,top=458 ,right=937 ,bottom=513 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='�ε�����' ,left=56 ,top=534 ,right=286 ,bottom=590 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='������ຸ����(``)' ,left=53 ,top=463 ,right=283 ,bottom=519 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='���ں���������(``)' ,left=53 ,top=384 ,right=283 ,bottom=439 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='���ޱ�(VAT����)' ,left=56 ,top=318 ,right=286 ,bottom=373 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='ǰ�ǹ�ȣ' ,left=56 ,top=251 ,right=286 ,bottom=307 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='�������ؼ�����' ,left=56 ,top=688 ,right=286 ,bottom=738 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='��������' ,left=706 ,top=532 ,right=937 ,bottom=593 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='��������' ,left=1357 ,top=611 ,right=1588 ,bottom=672 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='����â��' ,left=1357 ,top=534 ,right=1588 ,bottom=593 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='���ں�������' ,left=704 ,top=386 ,right=934 ,bottom=442 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<C>id='RQST_NO', left=302, top=191, right=693, bottom=238</C>
	<C>id='TERMS_TRANS', left=296, top=537, right=688, bottom=590</C>
	<C>id='CH_AMT', left=296, top=455, right=688, bottom=513, Dec=0</C>
	<C>id='DB_AMT', left=302, top=386, right=693, bottom=439, Dec=0</C>
	<C>id='TERMS_PAY', left=955, top=534, right=1347, bottom=590</C>
	<C>id='CH_RATE', left=955, top=458, right=1347, bottom=516</C>
	<C>id='DB_RATE', left=955, top=384, right=1347, bottom=442</C>
	<C>id='PREPAY_AMT_RATE', left=955, top=318, right=1347, bottom=368</C>
	<C>id='DATE_CON', left=955, top=251, right=1347, bottom=304</C>
	<C>id='RQST_DATE', left=955, top=185, right=1347, bottom=241</C>
	<C>id='PREPAY_AMT', left=296, top=320, right=688, bottom=368, Dec=0</C>
	<C>id='CON_NO', left=302, top=257, right=693, bottom=304</C>
	<C>id='AC_DATE', left=1609, top=185, right=1942, bottom=241</C>
	<C>id='BUR_TRANS', left=1603, top=254, right=1942, bottom=310</C>
	<C>id='VEND_NM', left=1606, top=318, right=1939, bottom=373</C>
	<C>id='TERM_GRN', left=1609, top=381, right=1939, bottom=437</C>
	<C>id='PUT_WH', left=1606, top=534, right=1939, bottom=590</C>
	<C>id='DATE_DDL', left=1606, top=609, right=1937, bottom=669</C>
	<C>id='OSV_PVR', left=299, top=691, right=1939, bottom=738, align='left'</C>
	<C>id='SITE_NM', left=1609, top=460, right=1939, bottom=516</C>
	<L> left=50 ,top=527 ,right=1950 ,bottom=529 </L>
	<L> left=50 ,top=804 ,right=1950 ,bottom=804 </L>
	<L> left=291 ,top=180 ,right=291 ,bottom=878 </L>
	<T>id='û��Ư�����' ,left=56 ,top=743 ,right=286 ,bottom=804 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='ǰ��Ư�����' ,left=56 ,top=812 ,right=286 ,bottom=873 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='÷������' ,left=58 ,top=609 ,right=288 ,bottom=675 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<C>id='CON_NOTE', left=296, top=810, right=1945, bottom=870, align='left'</C>
	<L> left=50 ,top=680 ,right=1950 ,bottom=680 </L>
	<L> left=701 ,top=180 ,right=701 ,bottom=606 </L>
	<C>id='REAL_FILE', left=299, top=616, right=1347, bottom=669</C>
	<C>id='RQST_MEMO', left=296, top=746, right=1937, bottom=804, align='left'</C>
	<L> left=950 ,top=180 ,right=950 ,bottom=606 </L>
</B>
<A>id=Area1 ,left=0,top=0 ,right=2101 ,bottom=132
	<R>id='pu070s_s1.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default7'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=188 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='* ������ü' ,left=50 ,top=50 ,right=450 ,bottom=111 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<X>left=50 ,top=111 ,right=1950 ,bottom=188 ,backcolor=#A6CAF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=201 ,top=111 ,right=201 ,bottom=188 </L>
			<L> left=1701 ,top=111 ,right=1701 ,bottom=188 </L>
			<L> left=799 ,top=111 ,right=799 ,bottom=188 </L>
			<L> left=1410 ,top=111 ,right=1410 ,bottom=188 </L>
			<T>id='����' ,left=58 ,top=119 ,right=196 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='���»��' ,left=214 ,top=122 ,right=791 ,bottom=183 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�����ݾ�' ,left=807 ,top=119 ,right=1093 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�����ݾ�' ,left=1109 ,top=119 ,right=1402 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='������' ,left=1418 ,top=119 ,right=1691 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=1101 ,top=111 ,right=1101 ,bottom=188 </L>
			<T>id='��������(%)' ,left=1717 ,top=119 ,right=1939 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=77 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=50 ,top=0 ,right=1950 ,bottom=77 ,border=true</X>
			<L> left=201 ,top=0 ,right=201 ,bottom=77 </L>
			<L> left=799 ,top=0 ,right=799 ,bottom=77 </L>
			<L> left=1410 ,top=0 ,right=1410 ,bottom=77 </L>
			<L> left=1101 ,top=0 ,right=1101 ,bottom=77 </L>
			<L> left=1701 ,top=0 ,right=1701 ,bottom=77 </L>
			<C>id='{CurRow}', left=58, top=5, right=196, bottom=71</C>
			<C>id='UD_EST_AMT', left=1418, top=5, right=1693, bottom=71, align='right', Dec=0, Decao=0</C>
			<C>id='TOT_FN_EST_AMT', left=1109, top=5, right=1400, bottom=71, align='right', Dec=0, Decao=0</C>
			<C>id='TOT_EST_AMT', left=804, top=5, right=1093, bottom=71, align='right', Dec=0, Decao=0</C>
			<C>id='VEND_NM', left=214, top=5, right=791, bottom=71</C>
			<C>id='UD_RATE', left=1709, top=5, right=1937, bottom=71</C>
		</B>
	</R>
</A>
<A>id=Area2 ,left=0,top=0 ,right=2101 ,bottom=132
	<R>id='pu070s_s2.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default8'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=270 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=50 ,top=111 ,right=1950 ,bottom=270 ,backcolor=#A6CAF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='* ǰ��' ,left=50 ,top=50 ,right=450 ,bottom=111 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<L> left=1341 ,top=191 ,right=1945 ,bottom=191 </L>
			<T>id='�԰�' ,left=439 ,top=122 ,right=754 ,bottom=257 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=762 ,top=111 ,right=762 ,bottom=270 </L>
			<T>id='����' ,left=773 ,top=122 ,right=881 ,bottom=257 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=889 ,top=191 ,right=1341 ,bottom=191 </L>
			<T>id='�ܰ�' ,left=894 ,top=196 ,right=1019 ,bottom=262 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=897 ,top=124 ,right=1238 ,bottom=185 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=1029 ,top=191 ,right=1029 ,bottom=270 </L>
			<T>id='�ݾ�' ,left=1035 ,top=198 ,right=1230 ,bottom=265 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=1249 ,top=122 ,right=1577 ,bottom=183 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�ܰ�' ,left=1249 ,top=196 ,right=1373 ,bottom=262 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�ݾ�' ,left=1392 ,top=196 ,right=1574 ,bottom=262 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=1582 ,top=111 ,right=1582 ,bottom=270 </L>
			<T>id='����' ,left=1590 ,top=119 ,right=1931 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�ܰ�' ,left=1590 ,top=204 ,right=1728 ,bottom=259 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=1733 ,top=191 ,right=1733 ,bottom=270 </L>
			<T>id='�ݾ�' ,left=1746 ,top=201 ,right=1929 ,bottom=262 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='ǰ��' ,left=58 ,top=119 ,right=426 ,bottom=257 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=431 ,top=114 ,right=431 ,bottom=267 </L>
			<L> left=889 ,top=114 ,right=889 ,bottom=267 </L>
			<L> left=1386 ,top=191 ,right=1386 ,bottom=270 </L>
			<L> left=1244 ,top=111 ,right=1244 ,bottom=265 </L>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=80 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=50 ,top=0 ,right=1950 ,bottom=79 ,backcolor=#FFFBF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<C>id='ITEM_NM', left=56, top=5, right=421, bottom=71</C>
			<L> left=431 ,top=0 ,right=431 ,bottom=79 </L>
			<C>id='ITEM_SIZE', left=439, top=5, right=751, bottom=71</C>
			<L> left=762 ,top=0 ,right=762 ,bottom=79 </L>
			<C>id='EST_CNT', left=767, top=5, right=886, bottom=71, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0</C>
			<L> left=889 ,top=0 ,right=889 ,bottom=79 </L>
			<C>id='DG_AMT', left=894, top=5, right=1029, bottom=71, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0</C>
			<L> left=1029 ,top=0 ,right=1029 ,bottom=79 </L>
			<L> left=1733 ,top=0 ,right=1733 ,bottom=79 </L>
			<C>id='FN_SUM_AMT', left=1738, top=5, right=1939, bottom=71, align='right', Dec=0, Decao=0</C>
			<L> left=1246 ,top=3 ,right=1246 ,bottom=77 </L>
			<L> left=1585 ,top=3 ,right=1585 ,bottom=77 </L>
			<L> left=1389 ,top=0 ,right=1389 ,bottom=74 </L>
			<C>id='DG_SUM_AMT', left=1035, top=8, right=1241, bottom=74, align='right', MargineX=3, Dec=0, Decao=0</C>
			<C>id='FN_EST_AMT', left=1590, top=5, right=1733, bottom=71, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Dec=0, Decao=0</C>
			<C>id='YS_SUM_AMT', left=1394, top=5, right=1582, bottom=71, align='right', MargineX=3, Dec=0, Decao=0</C>
			<C>id='YS_AMT', left=1251, top=8, right=1386, bottom=74, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Dec=0, Decao=0</C>
		</B>
	</R>
</A>
<A>id=Area3 ,left=0,top=0 ,right=2101 ,bottom=132
	<R>id='pu070s_s3.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default9'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=191 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='* ������缱' ,left=50 ,top=50 ,right=450 ,bottom=111 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<X>left=50 ,top=111 ,right=1950 ,bottom=191 ,backcolor=#A6CAF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=603 ,top=111 ,right=603 ,bottom=191 </L>
			<L> left=402 ,top=111 ,right=402 ,bottom=191 </L>
			<L> left=1000 ,top=111 ,right=1000 ,bottom=191 </L>
			<L> left=1201 ,top=111 ,right=1201 ,bottom=191 </L>
			<L> left=1601 ,top=111 ,right=1601 ,bottom=191 </L>
			<L> left=201 ,top=111 ,right=201 ,bottom=191 </L>
			<T>id='����' ,left=58 ,top=116 ,right=193 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='������' ,left=209 ,top=119 ,right=394 ,bottom=185 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=407 ,top=116 ,right=595 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�μ�' ,left=611 ,top=116 ,right=992 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=1008 ,top=116 ,right=1196 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�ǰ�' ,left=1207 ,top=116 ,right=1593 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�����Ͻ�' ,left=1609 ,top=116 ,right=1942 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=79 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=50 ,top=0 ,right=1950 ,bottom=79 ,backcolor=#FFFBF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=198 ,top=3 ,right=198 ,bottom=77 </L>
			<L> left=402 ,top=0 ,right=402 ,bottom=79 </L>
			<L> left=603 ,top=0 ,right=603 ,bottom=79 </L>
			<L> left=1000 ,top=0 ,right=1000 ,bottom=79 </L>
			<L> left=1201 ,top=0 ,right=1201 ,bottom=79 </L>
			<L> left=1601 ,top=0 ,right=1601 ,bottom=79 </L>
			<C>id='AP_TYPE_NM', left=58, top=5, right=193, bottom=71</C>
			<C>id='AP_DESC', left=1207, top=5, right=1593, bottom=71</C>
			<C>id='AP_STATUS_D_NM', left=1005, top=5, right=1193, bottom=71</C>
			<C>id='DEPTNM', left=606, top=5, right=995, bottom=71</C>
			<C>id='PAYGRD', left=407, top=5, right=601, bottom=71</C>
			<C>id='EMPNMK', left=212, top=5, right=394, bottom=71</C>
			<C>id='U_DATE', left=1606, top=5, right=1945, bottom=71</C>
		</B>
	</R>
</A>
<A>id=Area4 ,left=0,top=0 ,right=2101 ,bottom=132
	<R>id='pu070s_s4.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default9_1'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=191 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='* ������缱' ,left=50 ,top=50 ,right=450 ,bottom=111 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<X>left=50 ,top=111 ,right=1950 ,bottom=191 ,backcolor=#A6CAF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=603 ,top=111 ,right=603 ,bottom=191 </L>
			<L> left=402 ,top=111 ,right=402 ,bottom=191 </L>
			<L> left=1000 ,top=111 ,right=1000 ,bottom=191 </L>
			<L> left=1201 ,top=111 ,right=1201 ,bottom=191 </L>
			<L> left=1601 ,top=111 ,right=1601 ,bottom=191 </L>
			<T>id='����' ,left=58 ,top=116 ,right=193 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='������' ,left=209 ,top=119 ,right=394 ,bottom=185 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=407 ,top=116 ,right=595 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�μ�' ,left=611 ,top=116 ,right=992 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=1008 ,top=116 ,right=1196 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�ǰ�' ,left=1207 ,top=116 ,right=1593 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=201 ,top=111 ,right=201 ,bottom=191 </L>
			<T>id='�����Ͻ�' ,left=1609 ,top=116 ,right=1942 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=79 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=50 ,top=0 ,right=1950 ,bottom=79 ,backcolor=#FFFBF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=204 ,top=3 ,right=204 ,bottom=77 </L>
			<L> left=402 ,top=0 ,right=402 ,bottom=79 </L>
			<L> left=603 ,top=0 ,right=603 ,bottom=79 </L>
			<L> left=1000 ,top=0 ,right=1000 ,bottom=79 </L>
			<L> left=1201 ,top=0 ,right=1201 ,bottom=79 </L>
			<L> left=1601 ,top=0 ,right=1601 ,bottom=79 </L>
			<C>id='AP_TYPE_NM', left=56, top=3, right=198, bottom=69</C>
			<C>id='AP_DESC', left=1207, top=5, right=1595, bottom=71</C>
			<C>id='AP_STATUS_D_NM', left=1005, top=5, right=1196, bottom=71</C>
			<C>id='PAYGRD', left=410, top=5, right=587, bottom=71</C>
			<C>id='DEPTNM', left=606, top=5, right=990, bottom=71</C>
			<C>id='EMPNMK', left=214, top=5, right=397, bottom=71</C>
			<C>id='U_DATE', left=1606, top=5, right=1945, bottom=71</C>
		</B>
	</R>
</A>



	">
</object> 
<%=HDConstant.COMMENT_END%>
<script language=JavaScript for=pr1 event=OnError()>
    alert(pr1.ErrorMsg);
</script>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		