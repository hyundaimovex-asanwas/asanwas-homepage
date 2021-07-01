<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ������|���� ����	�� �����|���� ����
 * ���α׷�ID 	: RV200I_N			�� RV200I_N_biz
 * J  S  P  	: rv200i_N			�� rv200i_N_biz
 * �� �� ��     : Rv200I_N			�� Rv200I_N_biz
 * ���ν���     : PR_RV200I_XX		�� PR_RV200I_XX_biz
 * �������     : �ο�, ���� �����û - ������ ����
 * [  ��  ��  ][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2007-10-11][�ɵ���] ���� �ߺ� �Է� Ȯ���ϰ� ��ġ��
 * [2007-12-21][�ɵ���] ��������/��ǰ ���ý� ����Ÿ�Ե� ���� �޾� ��ȸ
 * [2009-03-11][�ɵ���] ������ǰ �߰��� ���� ��ǰ ���డ���ϰ� ���� 
						�׿� ���ʿ��� ��ũ��Ʈ�� ���̴� ��� ����~
 * [2010-01-06][�ɵ���] ������ ��� ����( line 609)
 * [2010-02-09][�ɵ���] ������ ������Ʈ : �ο�+���� ��ü!
 * 						���� �׸��忡 ������� GRID �߰�. ���� ���� �߰� / ���� / ���� 
 * 						��� ������ �κ� = only ������������
 * 						�ϴ� ������ ��ܦ� ������ ����
 * 										�� ��������, �ð� ���������� ����� �� �ְ�!!!! (3�� �մԵ�..)
 * 										��   (������ ���⿡ ������ ������ ���� ���ν�����..��..��_�� �� üũ...)
 * 										��   (������ ���⿡ ������ ������ ���� ���ν�����..��..��_�� �� üũ...)
 *										��     ��� ��� Ȯ��(SALES.PR_DC_MAIN) (���ΰ�) pNIGHTS,pARRIVE_DATE
 *										��     ��Ͻ��� �ݿ�(SALES.PR_RV200I_04)	pNIGHTS�� ���.(��� ����)
 *										��     ��ĳ���� ����(SALES.PR_RV200I_03)	pNIGHTS,pARRIVE_DATE �Ѵ� ���.(==���)
 *										��     ��������� �Է� (trv020)	pNIGHTS,V_ARRIVE_DATE (==���)
 *										��     ������� ����-�⺻���(SALES.PR_RV200I_02) (==���)
 * [2010-02-25][�ɵ���] ����� ���ں񿩺�, �ĺ񿩺� �߰�(���� �׸� �ڸ���..)
 *						�ݰ��� : ����, �Ļ� ����, 
 *						���� : 
 *	2�� ����� �޾Ƴ���.. 4������ �Է��ϴ� ���� ? ����..����..;
 *		�� ��Ͻ��� �ݿ� ���� ����� �� ��� �״��!
 * [2010-04-22][�ɵ���] ������� �Է� �� bound/���� �����Ǵ� �̺�Ʈ�� �� ���ͽð� ���� �ҷ�����..
 *						(tr_search �������� ��)
 * [2013-11-26][�ɵ���] �԰�ð�. ����� �������� ���� (�����ڵ�  item3=y)
 * [2015-09-16][�ɵ���] ���� �ο�, ���� tab ������ Ȯ��
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan

    
    //�븮�� ����
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

    
    <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i_N.js"></script>
    <!--<script language=javascript src="<%=dirPath%>/Sales/common/js/rv200i_N_biz.js"></script> -->
<%
/*=============================================================================
                Developer Java Script
=============================================================================*/
%>
    <script language="javascript">
        var v_job = "H";
        var v_ut = "<%=v_ut%>";
        var c_cd = "<%=c_cd%>";
        
        var v_dirPath = "<%=dirPath%>";
        
        subimg__a_url = new Array();
        subimg__url = new Array();
        subimg__a_url[0] = new Image();
        subimg__a_url[1] = new Image();
        subimg__url[0] = new Image();
        subimg__url[1] = new Image();
    
        subimg__a_url[0].src="<%=dirPath%>/Sales/images/tab_05_on.gif";
        subimg__a_url[1].src="<%=dirPath%>/Sales/images/tab_04_on.gif";
        subimg__url[0].src="<%=dirPath%>/Sales/images/tab_05.gif";
        subimg__url[1].src="<%=dirPath%>/Sales/images/tab_04.gif";
        
        var sub_click_img = 1;
<%
///////////////////////////////////////////////////////////////////////////////
// Description  :  ������ �ε�
// Parameter    :
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}
        
        function fnInit(){
            msgTxt.innerHTML= "�ʱ�ȭ���Դϴ�. ��ø� ��ٷ� �ֽñ� �ٶ��ϴ�.";

   			fnShowLoading(410,180);
        
            changesubclick(1);
            cfStyleGrid(getObjectFirst("gr_block"), "viewField");
            cfStyleGrid(getObjectFirst("gr_cust"), "comn");
            cfStyleGrid(getObjectFirst("gr_tourlist"), "comn1");
            cfStyleGrid(getObjectFirst("gr_carlist"), "comn1");
            
            //ȭ�� ��Ʈ��
//            fnCustDisplay(""); (���� ����)
            fnSearchDataChange(); //(��� �˻��κ�)

            //���ܱ���(bound_gu)
            init_boundDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM024&s_item1=Y";
            init_boundDs.Reset();
            
            //���
            init_saupGuDs.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CU004&s_item3=Y";
            init_saupGuDs.Reset();
            
            //���� �ڵ�
//            init_businessDs.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
//            init_businessDs.Reset();
           
            //����Ÿ�� ���ʵ����� ����
            init_blockTypeDs.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV002";
            init_blockTypeDs.Reset();
            
            //����
            init_ageDs.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV014&s_item1=Y";
            init_ageDs.Reset();
            
            //�湮����(cust_type)
            init_custTypeDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV003&s_item1=Y&s_item4=Y";
            init_custTypeDs.Reset();
            
            //����
            init_joinDs.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV006&s_item1=Y";
            init_joinDs.Reset();
            
			//2010-03-02 ������� ���а� by �ɵ��� 
			//���ں� ���� ����  (����=Y, ����=N) (������=��������)
            init_carownerDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY010&s_item1=Y";
            init_carownerDs.Reset();
            
			//�ĺ� ���� ����  (����=Y, ����=N) (������=�׸��ڵ�(theme_cd)
            init_themeDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY010&s_item1=Y";
            init_themeDs.Reset();


            //���ֿ��� (����=Y, ު����=N)
            init_jejuDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM020&s_item1=Y";
            init_jejuDs.Reset();
            
            //�ָ����� (�ָ�=Y, ����=N)
            init_weekendDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM019&s_item1=Y";
            init_weekendDs.Reset();
			

			//�԰�ð� (RM015:����� �ð��븸item3=Y)
			init_arrTimeDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM015&s_item1=Y&s_item3=Y";
			init_arrTimeDs.Reset();
			
            // �����걸��(RV036,1=��, 2=��)
            init_payPreDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV036&s_item1=Y";
            init_payPreDs.Reset();

            // ���걸�� (RV035, 1=����, 2=�����)
            init_paySaupDs.dataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV035&s_item1=Y";
            init_paySaupDs.Reset();

            ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
                "JSP(O:NATION=initds1,O:PASS=initds6,O:IMAGE=imgDs)",
                "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
            tr_post(tr1);
        }
        
        function fnCustCancel(){
            ds_cust.UndoAll();
            ds_block.NameValue(v_block_row, "RSV_PERSONS") = ds_cust.CountRow;
        }
        
        /*
         * ��ġ�� ���� ���
         */
        function fnHoldEmp(){
		    var strURL = "<%=dirPath%>/Sales/help/sy030h.jsp";
		    var strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		    var return_value = showModalDialog(strURL,arrParam,strPos); 
        	
    		if(return_value!=undefined){
    			var arrParam = return_value.split(";");
	            ds_cust.NameValue(ds_cust.RowPosition, "HOLD_EMPNO") = arrParam[0];	//empno
	            ds_cust.NameValue(ds_cust.RowPosition, "HOLD_EMPNM") = arrParam[1];	//empnm
    		}
        }

        /*
         * Sales\common\js\rv200i_N_biz.js �� �ҽ��� ������. �����籸������ ���� �ѱ۱����������� ����. 20140118
         */
     	var v_cust_flag = "";
         var v_room_flag = "";
         var v_block_row = 0;
         var v_cust_row = 0;
         /**
          * Tab Image Control
          */
         function fnOnChangTab(tab_idx){
//         	alert(tab_idx);
             if(tab_idx=='1'){
                 getObjectFirst("tb_tourlist").style.display = "inline";
                 getObjectFirst("tb_car").style.display = "none";
             } else if(tab_idx=='2'){
                 getObjectFirst("tb_tourlist").style.display = "none";
                 getObjectFirst("tb_car").style.display = "inline";
             }
         }
         
         function changesub (no) {
             for (i=1; i<= 3;i++){
     	        if(eval("document.images.sub"+i)!=undefined){
     	            obj = eval("document.images.sub"+i);
     	            if (i == no)
     	                obj.src = subimg__a_url[i-1].src;
     	            else
     	                obj.src = subimg__url[i-1].src;
     	        }
             }
         }

         function changesubout (no) {
             changesubclick(sub_click_img);
         }

         function changesubclick (no) {
             sub_click_img = no;
             for (i=1; i<= 3;i++){
     	        if(eval("document.images.sub"+i)!=undefined){
     	            obj = eval("document.images.sub"+i);
     	            if (i == no)
     	              obj.src = subimg__a_url[i-1].src;
     	            else
     	              obj.src = subimg__url[i-1].src;
     	        }
             }
         }

         var s_depart_date = ""; //�������
         var s_accept_no = "";   //��û����ȣ
         var v_function = "";    //�������

         //  ��û����ȣ ��ȸ (onKillFocues)
         function fnAcceptNo(dirPath, servletPath){
             if(s_accept_no != getObjectFirst("v_accept_no").Text.trim() && getObjectFirst("v_accept_no").Text.trim()!="" && getObjectFirst("v_accept_no").Text.trim()!=null)
             {
                 s_accept_no = getObjectFirst("v_accept_no").Text.trim();
                 v_function = "ACCEPT";
                 v_cust_flag = "S";

                 //���� �����͸� �����Ѵ�.+ ��Ȱ��ȭ.. 
                 fnDataSetClear();
                 
     	        var v_param = "proType=S"
                             + ",v_business="+v_business.ValueOfIndex("SAUP_SID", v_business.Index)
     	                    + ",v_accept_no="+getObjectFirst("v_accept_no").Text.trim()
                             + ",v_client_sid="+ getObjectFirst("v_client_sid").value
                             + ",v_bound_seq="+ v_bound_seq.text;

     	        ln_TRSetting(tr_search,
     	                    dirPath + servletPath+"Rv200I_N_biz",
     	                    "JSP(O:SEARCH=ds_search)",
     	                    v_param);
     	        tr_post(tr_search);
             }
         }

         //  ��û�� ��ȣ�� ��ȸ��
         function fnAcceptNoAfter(dirPath, servletPath){
             if(s_accept_no != getObjectFirst("v_accept_no").Text.trim() && getObjectFirst("v_accept_no").Text.trim()!="" && getObjectFirst("v_accept_no").Text.trim()!=null)
             {
                 s_accept_no = getObjectFirst("v_accept_no").Text.trim();

                 //���� �����͸� �����Ѵ�.
                 
                 var v_param = "proType=S"
                             + ",v_business="+v_business.ValueOfIndex("SAUP_SID", v_business.Index)
                             + ",v_accept_no="+getObjectFirst("v_accept_no").Text.trim()
                             + ",v_bound_seq="+ v_bound_seq.text;

                 ln_TRSetting(tr_search,
                             dirPath + servletPath+"Rv200I_N_biz",
                             "JSP(O:SEARCH=ds_search)",
                             v_param);
                 tr_post(tr_search);
             }
         }
      
         /**
          * ������ڷ� ��ȸ��
          * 	1) ��û�� ��ȣ�� �����ϸ� == �̸� �����ϰ� �� ���ʵ�� (�ٵ� �̷��� �ص� ���� ������ 1)
          *	2) ��û�� ��ȣ�� ������   == ���� �ű� ���
          */
         function fnDepartDate(dirPath, servletPath){
         	//alert("fnDepartDate");
             if(s_depart_date != getObjectFirst("v_depart_date").Text.trim()
                 && getObjectFirst("v_depart_date").Text.trim()!="" 
                 && getObjectFirst("v_depart_date").Text.trim()!=null
                 && getObjectFirst("v_depart_date").Text.trim().length==8){

                 s_depart_date = getObjectFirst("v_depart_date").Text;
                 
                 v_function = "DEPART";
                 v_cust_flag = "S";
                 //���� �����͸� �����Ѵ�.
                 fnDataSetClear();
                 var v_param = "proType=S"
                             + ",v_business="+v_business.ValueOfIndex("SAUP_SID", v_business.Index)
                             + ",v_depart_date="+getObjectFirst("v_depart_date").Text
                             + ",v_bound_seq="+ v_bound_seq.text;
                 //alert(v_param);
                 ln_TRSetting(tr_search, 
                     dirPath + servletPath+"Rv200I_N_biz",
                     "JSP(O:SEARCH=ds_search)",
                     v_param);
                 tr_post(tr_search);
             }
         }
         
         // ds_search OnLoadCompleted Event
         function fnSearchEnd(row){
     	    if(v_function == "ACCEPT"){	//��û����ȣ�� ��ȸ���� �븸~!
                 if(row==0) return;
     	        
     	        s_depart_date 							= getObjectFirst("ds_search").NameValue(row, "DEPART_DATE");
                 getObjectFirst("v_accept_sid").value 	= getObjectFirst("ds_search").NameValue(row, "ACCEPT_SID");
                 getObjectFirst("v_client_sid").value 	= getObjectFirst("ds_search").NameValue(row, "CLIENT_SID");
                 getObjectFirst("v_client_nm").value  	= getObjectFirst("ds_search").NameValue(row, "CLIENT_NM");
                 
                 //2009-03-27 �߰� by �ɵ���
                 //����� ��û����ȣ ��ȸ�� bound, ���� ������. �ٵ� �ӵ���.. ��� �������� ��..��;;;
     			if(getObjectFirst("ds_search").NameValue(row, "BOUND_GU")!="NONE"){//NONE�� ��������� ���� ��� (��������)
     				v_bound.index = v_bound.IndexOfColumn("detail", getObjectFirst("ds_search").NameValue(row, "BOUND_GU") );
     			    //fnBound("", "/servlet/sales.menu.help.");
     				v_business.index = v_business.IndexOfColumn("saup_sid", getObjectFirst("ds_search").NameValue(row, "SAUP_SID") );
     			};
     			
                 if((getObjectFirst("ds_search").NameValue(row, "DEPART_DATE")=="") ||(getObjectFirst("ds_search").NameValue(row, "DEPART_DATE")==null)){
                     getObjectFirst("v_depart_date").Enable = "True";
                 }
                 
                 getObjectFirst("v_tour_check").style.display = "inline";
     	    } else if(v_function == "DEPART"){
     	        s_accept_no = null;
     	    }
             v_cust_row = 0;
         }
         
         // Reset Btn Click
         function fnReset(){
             if(!confirm("�ʱ�ȭ�Ͻðڽ��ϱ�?")) return;
             v_function = "RESET";
             fnDataSetClear();        //���� �˻����� �����͸� �����Ѵ�.
         }

         // Reset Btn Click
         function fnResetAll(){
             if(!confirm("�ʱ�ȭ�Ͻðڽ��ϱ�?")) return;
             v_function = "RESET";
             fnDataSetClear();        //���� �˻����� �����͸� �����Ѵ�.
         }



     	// bound �����
         function fnBound(dirPath, servletPath){
     		if(v_function!="DEPART"){
     		//���� �ڵ�
     		init_businessDs.Dataid  = dirPath + servletPath +"Sy003H?dsType=1&proType=S&s_BoundGu="+v_bound.ValueOfIndex("detail", v_bound.Index);
     		init_businessDs.Reset();
     		}
     	};
     	
     	
         // Block Type �����
         function fnBlockType(dirPath, servletPath){
         	//alert("fnBlockType");
             if(v_blockType.Index==0) return;
             
             if((getObjectFirst("v_client_nm").value=="") || (getObjectFirst("v_client_nm").value==null)){
                 alert("���¾�ü�� ���� �����Ͻñ� �ٶ��ϴ�.");
                 v_blockType.Index = 0;
                 return;
             }
             if((v_blockType.ValueOfIndex("DETAIL", v_blockType.Index)!="") && (v_blockType.ValueOfIndex("DETAIL", v_blockType.Index)!=null)){
                 v_function = "BLOCK";
                 v_cust_flag = "S";

                 //getObjectFirst("block_title").innerHTML = "<b>"+ v_blockType.Text + "</b>";

                 //���� �����͸� �����Ѵ�.
                 fnDataSetClear();
         
                 var v_param = "proType=S"
                             + ",v_business="+v_business.ValueOfIndex("SAUP_SID", v_business.Index)
                             + ",v_accept_no="+getObjectFirst("v_accept_no").Text.trim()
                             + ",v_blockType="+v_blockType.ValueOfIndex("DETAIL", v_blockType.Index)
                             + ",v_client_sid="+getObjectFirst("v_client_sid").value
                             + ",v_depart_date="+getObjectFirst("v_depart_date").Text.trim()
                             + ",v_goods_sid="+v_goods_nm.ValueOfIndex("GOODS_SID", v_goods_nm.Index)
                             + ",v_accept_sid="+getObjectFirst("v_accept_sid").value
                             + ",v_nights="+getObjectFirst("v_nights").value
                             + ",v_roomType="+v_roomType.ValueOfIndex("ROOM_TYPE_SID", v_roomType.Index);

     //alert("fnBlockType v_param : " + v_param);
                 ln_TRSetting(tr1, 
                             dirPath + servletPath+"Rv200I_N_biz",
                             "JSP(O:ROOM=ds_room)",
                             v_param);
                 tr_post(tr1);
             }
         }

         /**
          * Room Type �����
          */
         function fnRoomType(dirPath, servletPath){
         	//alert("fnRoomType");
             if(v_blockType.ValueOfIndex("DETAIL", v_blockType.Index)!=""
            	 && v_blockType.ValueOfIndex("DETAIL", v_blockType.Index)!=null
                 && v_roomType.ValueOfIndex("ROOM_TYPE_SID", v_roomType.Index)!="0"
                 && getObjectFirst("v_client_sid").value!=""
            	 && getObjectFirst("v_client_sid").value!=null){
                 v_function = "ROOM";
                 v_cust_flag = "S";
                 
                 getObjectFirst("block_title").innerHTML ="<b>"+ v_roomType.Text.substring(0, 5)+"</b>";

                 //���� �����͸� �����Ѵ�.
                 fnDataSetClear();
         
                 var v_param = "proType=S"
                             + ",v_business="+v_business.ValueOfIndex("SAUP_SID", v_business.Index)
                             + ",v_accept_no="+getObjectFirst("v_accept_no").Text.trim()
                             + ",v_blockType="+v_blockType.ValueOfIndex("DETAIL", v_blockType.Index)
                             + ",v_client_sid="+getObjectFirst("v_client_sid").value
                             + ",v_depart_date="+getObjectFirst("v_depart_date").Text.trim()
                             + ",v_goods_sid="+v_goods_nm.ValueOfIndex("GOODS_SID", v_goods_nm.Index)
                             + ",v_accept_sid="+getObjectFirst("v_accept_sid").value
                             + ",v_nights="+getObjectFirst("v_nights").value
                             + ",v_roomType="+v_roomType.ValueOfIndex("ROOM_TYPE_SID", v_roomType.Index);
                 //alert(v_param);
                 ln_TRSetting(tr1, 
                             dirPath + servletPath+"Rv200I_N_biz",
                             "JSP(O:BLOCK=ds_block, O:ROOMCHANGE=ds_roomChange)",
                             v_param);
                 tr_post(tr1);
             }
         }

         /**
          * ������ ���
          */
         function fnGetTour(dirPath, servletPath){
             var var_checked = "N";
             if(getObjectFirst("v_accept_check").checked)
                 var_checked = "Y";
                 
             var v_param = "proType=S"
                         + ",v_accept_sid="+getObjectFirst("v_accept_sid").value
                         + ",v_accept_check="+var_checked;

             ln_TRSetting(tr1, 
                         dirPath + servletPath+"Rv200I_N_biz",
                         "JSP(O:TOUR=ds_tour)",
                         v_param);
             tr_post(tr1);
         }

         /**
          *  ForeCasting ����
          */
         function fnGetForcasting(dirPath, servletPath){
     /*        if(getObjectFirst("v_fr_date").Text.trim()=="" || getObjectFirst("v_fr_date").Text.trim().length!=8){
                 alert("����(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
                 getObjectFirst("v_fr_date").focus();
                 return;
             }
             
             if(getObjectFirst("v_to_date").Text.trim()=="" || getObjectFirst("v_to_date").Text.trim().length!=8){
                 alert("����(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
                 getObjectFirst("v_to_date").focus();
                 return;
             }
             
             var v_param = "proType=S"
                         + ",v_blockType="+v_blockType.ValueOfIndex("DETAIL", v_blockType.Index)
                         + ",v_client_sid="+getObjectFirst("v_client_sid").value
                         + ",v_goods_sid="+v_goods_nm.ValueOfIndex("GOODS_SID", v_goods_nm.Index)
                         + ",v_nights="+getObjectFirst("v_nights").value
                         + ",v_fr_date="+getObjectFirst("v_fr_date").Text.trim()
                         + ",v_to_date="+getObjectFirst("v_to_date").Text.trim();
             ln_TRSetting(tr1, 
                         dirPath + servletPath+"Rv200I_N_biz",
                         "JSP(O:FORECASTING=ds_forecasting)",
                         v_param);
             tr_post(tr1);*/
         }
         
         /**
          * ������ �ܰ躰 DataSet ����
          */
         function fnDataSetClear(){
             if(v_function == "ACCEPT"){					//��û����ȣ killfocus
                 getObjectFirst("ds_block").ClearAll();
                 getObjectFirst("ds_cust").ClearAll();
                 getObjectFirst("ds_tour").ClearAll();
                 getObjectFirst("ds_car").ClearAll();
                 //getObjectFirst("ds_forecasting").ClearAll();
                 
                 getObjectFirst("v_bound").Enable 		= "False";		
                 getObjectFirst("v_bound_seq").Enable 		= "False";		
                 getObjectFirst("v_business").Enable 	= "False";
                 getObjectFirst("v_accept_no").Enable 	= "False";
                 getObjectFirst("v_depart_date").Enable = "False";

                 //getObjectFirst("forcasting_btn").style.display      = "inline";
                 getObjectFirst("v_accept_btn").style.display        = "none";
                 
                 if((v_ut=="") || (v_ut==null)){
                     getObjectFirst("v_client_btn").style.display        = "none";
                 }
//                 getObjectFirst("v_event_btn").style.display         = "none";
                 getObjectFirst("btn_cust_add").style.display        = "none";
                 getObjectFirst("btn_cust_del").style.display        = "none";
                 getObjectFirst("btn_cust_save").style.display       = "none";
                 getObjectFirst("btn_cust_cancel").style.display       = "none";
//                 getObjectFirst("btn_amtSave").style.display         = "inline";
                 
                 fnCustClear();
             } else if(v_function == "DEPART"){
                 getObjectFirst("ds_block").ClearAll();
                 getObjectFirst("ds_cust").ClearAll();
                 getObjectFirst("ds_tour").ClearAll();
                 getObjectFirst("ds_car").ClearAll();
                 //getObjectFirst("ds_forecasting").ClearAll();

                 getObjectFirst("v_bound").Enable 		= "False";		
                 getObjectFirst("v_business").Enable = "False";
                 getObjectFirst("v_accept_no").Enable = "False";
                 getObjectFirst("v_depart_date").Enable = "False";

                 //getObjectFirst("forcasting_btn").style.display      = "inline";
                 getObjectFirst("v_accept_btn").style.display        = "none";
                 
                 if((v_ut=="") || (v_ut==null)){
                     getObjectFirst("v_client_btn").style.display        = "inline";
                 }
//                 getObjectFirst("v_event_btn").style.display         = "none";
                 getObjectFirst("btn_cust_add").style.display        = "none";
                 getObjectFirst("btn_cust_del").style.display        = "none";
                 getObjectFirst("btn_cust_save").style.display       = "none";
                 getObjectFirst("btn_cust_cancel").style.display       = "none";
//                 getObjectFirst("btn_amtSave").style.display         = "none";
                 
                 fnCustClear();
             } else if(v_function == "RESET"){		//���¹�ư Ŭ��
                 getObjectFirst("ds_search").ClearAll();
                 getObjectFirst("ds_block").ClearAll();
                 getObjectFirst("ds_cust").ClearAll();
                 getObjectFirst("ds_tour").ClearAll();
                 getObjectFirst("ds_room").ClearAll();
                 getObjectFirst("ds_car").ClearAll();
                             
                 getObjectFirst("v_blockType").Index = 0;
                 getObjectFirst("v_bound_seq").text = "";
                 getObjectFirst("v_bound_total_seq").text = "";
                 getObjectFirst("v_bound").Enable 		= "True";		
                 getObjectFirst("v_business").Enable = "True";
                 getObjectFirst("v_accept_no").Enable = "True";
                 getObjectFirst("v_depart_date").Enable = "True";

                 //getObjectFirst("forcasting_btn").style.display      = "none";
                 getObjectFirst("v_accept_btn").style.display        = "inline";
                 
                 if((v_ut == "") || (v_ut == null)){
                     getObjectFirst("v_client_btn").style.display        = "inline";
                 }
//                 getObjectFirst("v_event_btn").style.display         = "none";
                 getObjectFirst("btn_cust_add").style.display        = "none";
                 getObjectFirst("btn_cust_del").style.display        = "none";
                 getObjectFirst("btn_cust_save").style.display       = "none";
                 getObjectFirst("btn_cust_cancel").style.display       = "none";
//                 getObjectFirst("btn_amtSave").style.display         = "none";
                 
                 getObjectFirst("v_tour_check").style.display        = "none";
                 
//                 getObjectFirst("v_fr_date").Text = "";
//                 getObjectFirst("v_to_date").Text = "";
                 getObjectFirst("v_manage_no").Text = "";
                 getObjectFirst("v_accept_sid").value = "";
                 
                 if((v_ut=="") || (v_ut==null)){
                     getObjectFirst("v_accept_no").Text = "";
     	            getObjectFirst("v_client_sid").value = "";
     	            getObjectFirst("v_client_nm").value = "";
                 } else {
                     getObjectFirst("v_accept_no").Text = c_cd;
                 }
                 getObjectFirst("v_depart_date").Text = "";
                 getObjectFirst("v_depart_time").Text = "";
                 getObjectFirst("v_arrive_date").Text = "";
                 getObjectFirst("v_arrive_time").Text = "";
                 getObjectFirst("v_nights").value = "";
                 getObjectFirst("v_goods_nm").Enable = "False";
                 getObjectFirst("v_blockType").Enable = "False";
                 getObjectFirst("v_roomType").Enable = "False";
                 getObjectFirst("v_event_no").value = "";
                 getObjectFirst("v_event_sid").value = "";
                 getObjectFirst("v_event_nm").value = "";
                 
                 v_function = "";
                 v_cust_flag = "";
                 s_depart_date = "";
                 s_accept_no = "";
                 v_block_row = 0;
                 
                 fnCustClear();
                 
                 getObjectFirst("ds_room").ClearAll();

             } else if(v_function == "BLOCK"){

                 getObjectFirst("ds_block").ClearAll();
                 getObjectFirst("ds_cust").ClearAll();

                 getObjectFirst("btn_cust_add").style.display        = "none";
                 getObjectFirst("btn_cust_del").style.display        = "none";
                 getObjectFirst("btn_cust_save").style.display       = "none";
                 getObjectFirst("btn_cust_cancel").style.display       = "none";
//                 getObjectFirst("btn_amtSave").style.display         = "none";
                 
                 fnCustClear();
             } else if(v_function == "ROOM"){
                 getObjectFirst("ds_block").ClearAll();
                 getObjectFirst("ds_cust").ClearAll();

                 getObjectFirst("btn_cust_add").style.display        = "none";
                 getObjectFirst("btn_cust_del").style.display        = "none";
                 getObjectFirst("btn_cust_save").style.display       = "none";
                 getObjectFirst("btn_cust_cancel").style.display       = "none";
//                 getObjectFirst("btn_amtSave").style.display         = "inline";
                 
                 fnCustClear();
                 
                 v_block_row = 0;
             }
         }
         
         function fnCustClear(){//����ڻ�.
             getObjectFirst("photo").src = v_dirPath + "/Sales/images/00000.gif";
             getObjectFirst("cust_company_nm").value = "";
             getObjectFirst("cust_positions").value = "";
             getObjectFirst("cust_birthday").value = "";
             getObjectFirst("cust_sex").value = "";
             getObjectFirst("cust_country_nm").value = "";
             getObjectFirst("cust_work_no").value = "";
             getObjectFirst("cust_unity_no").value = "";
             getObjectFirst("cust_north_purpose").value = "";
             getObjectFirst("cust_remarks").value = "";
         }

         /**
          * ��û�� ��ȣ ��ȸ
          */
         function fnAcceptNoPopup(dirPath, servletPath){
             v_cust_row = 0;
             var arrResult   = new Array();
             arrResult = fnAcceptNoPop(dirPath);
             if (arrResult != null) {
                 arrParam = arrResult.split(";");
                 if(getObjectFirst("ds_search").CountRow>0)
                     getObjectFirst("ds_search").DeleteAll();
                 
                 getObjectFirst("v_accept_sid").value = arrParam[0];
                 getObjectFirst("v_accept_no").Text   = arrParam[1];
                 
                 fnAcceptNo(dirPath, servletPath);
             }
         }
         
         /**
          * �˻����� ����ó  �˾� 
          */
         function fnSelClientPopup(dirPath, servletPath) {
             v_cust_row = 0;
             var arrParam    = new Array();
             var arrResult   = new Array();
             var strURL; 
             var strPos;
             
             arrResult = fnClientPop(dirPath,'');
         
             if (arrResult != null) {
                 arrParam = arrResult.split(";");
                 v_client_sid.value = arrParam[0];
                 v_client_nm.value = arrParam[1];
                 if(getObjectFirst("ds_search").CountRow==0) 
                     return;

                 fnRoomType(dirPath, servletPath);
             } else {
                 v_client_sid.value = "";
                 v_client_nm.value  = "";
             }               
         }

         /**
          * ��� Ŭ���� ������ ��� ��ȸ �� ds_cust �ʱ�ȭ
          */
         function fnGetDataCust(dirPath, servletPath){
             v_cust_row = 0;
             var v_param = "proType=S"
                         + ",v_m_rsv_sid="+ getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "M_RSV_SID")
                         + ",v_blockType="+v_blockType.ValueOfIndex("DETAIL", v_blockType.Index)
                         + ",v_depart_date="+getObjectFirst("v_depart_date").Text.trim()
                         + ",v_goods_sid="+v_goods_nm.ValueOfIndex("GOODS_SID", v_goods_nm.Index)
                         + ",v_roomType="+v_roomType.ValueOfIndex("ROOM_TYPE_SID", v_roomType.Index);
             v_cust_flag = "S_cust";
             ln_TRSetting(tr1, 
                 dirPath + servletPath+"Rv200I_N_biz",
                 "JSP(O:CUST=ds_cust)",
                 v_param);
             tr_post(tr1);
         }
         
         /**
          *  ���� ���� 
          */
         function fnRoomChange(dirPath, servletPath){
             if(getObjectFirst("ds_block").CountRow==0){
                 alert("��������� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
                 return;
             }
             
             if(ds_cust.CountRow==0){
                 alert("������ ����� �����ϴ�.");
                 return;
             }
             if(getObjectFirst("ds_cust").IsUpdated){
                 alert("������ ��ܿ� ������� ���� �����Դϴ�.\n\n���� ������ ��� ������ �Ͻñ� �ٶ��ϴ�.");
                 return;
             }
             
             getObjectFirst("ds_block").DeleteRow(getObjectFirst("ds_block").RowPosition);
             
             v_cust_flag = "S";
             
             var v_param = "proType=A"
                         + ",v_m_rsv_sid="+ getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "M_RSV_SID")
                         + ",v_roomType="+v_roomChange.ValueOfIndex("ROOM_TYPE_SID", v_roomChange.Index);

     //alert("fnRoomChange v_param : " + v_param);
     //"JSP(I:REG_ROOM=ds_block, O:ROOM_RESULT=ds_room_result)",
             
             ln_TRSetting(tr_save, 
                 dirPath + servletPath+"Rv200I_N_biz",
                 "JSP(O:ROOM_RESULT=ds_room_result)",
                 v_param);
             tr_post(tr_save);
         }
         
         /**
          *
          */
         function fnAmtSave(dirPath, servletPath){
             v_cust_flag = "S";
             
             var v_param = "proType=A"
                         + ",v_accept_sid="+getObjectFirst("v_accept_sid").value;
     //alert("fnAmtSave v_param : " + v_param);
             ln_TRSetting(tr_save, 
                 dirPath + servletPath+"Rv200I_N_biz",
                 "JSP(I:REG_AMT=ds_tour, O:AMT_RESULT=ds_amt_result)",
                 v_param);
             tr_post(tr_save);
         }

         // ��ȸ �����Ϳ� ���� ��Ʈ�� ����...
         function fnSearchDataChange(){
             if(getObjectFirst("ds_search").CountRow>0){
                 getObjectFirst("v_goods_nm").Enable  = "True";
                 getObjectFirst("v_blockType").Enable = "True";
                 getObjectFirst("v_roomType").Enable  = "True";
             } else {
                 getObjectFirst("v_goods_nm").Enable  = "False";
                 getObjectFirst("v_blockType").Enable = "False";
                 getObjectFirst("v_roomType").Enable  = "False";
             }
         }
         
         /**
          * ������ �����Ϳ� ���� Button Control
          */
         function fnCustButtonChange(){
             if(getObjectFirst("ds_block").CountRow>0){
                 getObjectFirst("btn_cust_add").style.display  = "inline";
                 getObjectFirst("btn_cust_del").style.display  = "inline";
                 getObjectFirst("btn_cust_save").style.display = "inline";
                 getObjectFirst("btn_cust_cancel").style.display       = "inline";
             } else {
                 getObjectFirst("btn_cust_add").style.display  = "none";
                 getObjectFirst("btn_cust_del").style.display  = "none";
                 getObjectFirst("btn_cust_save").style.display = "none";
                 getObjectFirst("btn_cust_cancel").style.display       = "none";
             }
         }
         
         /**
          * ������ ������ ���� Control
          */
         function fnCustInfoChange(){
             if(getObjectFirst("ds_cust").CountRow>0){
                 getObjectFirst("cust_mobile_no").readOnly = false;
                 getObjectFirst("cust_remarks").readOnly = false;
                 getObjectFirst("cust_north_purpose").readOnly = false;
//                 if(v_ut=="")
//                 	getObjectFirst("hold_btn").style.display = "inline";
             } else {
                 getObjectFirst("cust_mobile_no").readOnly = true;
                 getObjectFirst("cust_remarks").readOnly = true;
                 getObjectFirst("cust_north_purpose").readOnly = true;
//                 if(v_ut=="")
//                 	getObjectFirst("hold_btn").style.display = "none";
             }
         }
         
         /**
          * ������ �߰�
          */
         function fnApplyCust(dirPath, servletPath){
             if (ds1.IsUpdated) {
                 if(fnCustInfoCheck()!=true) return;
                 fnOnProgressStart();
                 v_cust_flag = "I";
                 ln_TRSetting(tr_cust, 
                     dirPath + servletPath+"Cu010I",
                     "JSP(I:REGIST=ds1,I:IMAGE=imgDs)",
                     "proType=A");
                 tr_post(tr_cust);
             } else {
                 alert("�� ������ ���� ������ �����ϴ�.");
             }
         }
         
         /**
          * ������ �߰�
          */
         function fnCancelCust(){
             getObjectFirst("ds1").undoall();
             getObjectFirst("imgDs").undoall();
             fnCustDisplay("");
         }
         
         /**
          * ������ ���� RESET
          */
         function fnResetCust(){
             ds1.ClearAll();
//             lc_country_gu.Index = 0;

             fnCustDisplay("");
             
//             getObjectFirst("regi_no").Text          = "";
//             getObjectFirst("pass_no").Text          = "";
//             getObjectFirst("pass_expire_date").Text = "";
//             getObjectFirst("birthday").Text         = "";
          
//             getObjectFirst("zip_cd").Text           = "";
//             getObjectFirst("eng_company_nm").Text   = "";
//             getObjectFirst("eng_position").Text     = "";
//             getObjectFirst("txt_company_nm").value  = "";
//             getObjectFirst("txt_positions").value   = "";
//             getObjectFirst("txt_cust_nm").value     = "";
//             getObjectFirst("txt_address1").value    = "";
//             getObjectFirst("txt_address2").value    = "";
//             getObjectFirst("txt_eng_addr1").value   = "";
//             getObjectFirst("country_cd").value      = "";
//             getObjectFirst("lc_nation").value       = "";
             
         }
         
         /**
          * �� ���� ��ȸ
          */
         function fnCustInfoFind(dirPath, servletPath){
//             var v_country_gu = lc_country_gu.ValueOfIndex("DETAIL", lc_country_gu.Index)
             var v_manage_no = "";
             
     /*        if(v_country_gu=="10"){
                 v_manage_no = getObjectFirst("regi_no").Text;
                 if(v_manage_no==""){
                     alert("�ֹι�ȣ�� ��Ȯ�ϰ� �Է��Ͻñ� �ٶ��ϴ�");
                     return false;
                 }
             } else {
                 v_manage_no = getObjectFirst("pass_no").Text;
                 if(v_manage_no==""){
                     alert("���ǹ�ȣ�� ��Ȯ�ϰ� �Է��Ͻñ� �ٶ��ϴ�");
                     return false;
                 }
             }*/
      
             v_cust_flag = "S";
             ln_TRSetting(tr1, 
                 dirPath + servletPath + "Cu010I",
                 "JSP(O:DEFAULT=ds1,O:IMAGE=imgDs)",
                 "proType=S,dsType=1,sManegeNo="+v_manage_no);
             tr_post(tr1);
         }


         // ������ �߰�- �߰���ư���� �߰��� ��.
         function fnCustAdd(dirPath, servletPath){
             var block_row  = getObjectFirst("ds_block").RowPosition;
             var max_person = eval(getObjectFirst("ds_block").NameValue(block_row, "MAX_PERSONS"));
             
             var cust_cnt = eval(getObjectFirst("ds_cust").CountRow);

             var s_manage_no = getObjectFirst("v_manage_no").Text;
             if(max_person<cust_cnt){
                 alert("�ִ� �ο��� �ʰ��߽��ϴ�.");
                 return;
             }
             
             if(s_manage_no==""){
                 alert("�ֹ�/���ǹ�ȣ�� ���� �Է��Ͻñ� �ٶ��ϴ�.");
                 getObjectFirst("v_manage_no").Focus();
                 return;
             }
             
     	    for(var i=1; i<=getObjectFirst("ds_cust").CountRow; i++){
     	        if(getObjectFirst("ds_cust").NameValue(i, "MANAGE_NO")==s_manage_no){
     	            alert("�̹� ��ϵ� ����� �����Դϴ�.");
     	            getObjectFirst("v_manage_no").Focus();
     	            return;
     	        }
     	    }
     	
             var v_param = "proType=S"
                         + ",v_business="    + v_business.ValueOfIndex("SAUP_SID", v_business.Index)
                         + ",v_accept_sid="  + getObjectFirst("v_accept_sid").value
     	                + ",v_client_sid="  + getObjectFirst("v_client_sid").value
     	                + ",v_depart_date=" + getObjectFirst("v_depart_date").Text
     	                + ",v_depart_time=" + getObjectFirst("v_depart_time").Text
     	                + ",v_nights="      + getObjectFirst("v_nights").value
     	                + ",v_goods_sid="   + getObjectFirst("ds_search").NameValue(getObjectFirst("ds_search").RowPosition, "GOODS_SID")
     	                + ",v_blockType="   + v_blockType.ValueOfIndex ("DETAIL", v_blockType.Index)
     	                + ",v_roomType="    + v_roomType.ValueOfIndex ("ROOM_TYPE_SID", v_roomType.Index)
                         + ",v_block_sid="   + getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "BLOCK_SID")
                         + ",v_room_sid="    + getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "ROOM_SID")
     	                + ",v_arrive_date=" + getObjectFirst("v_arrive_date").Text
     	                + ",v_arrive_time=" + getObjectFirst("v_arrive_time").Text
     	                + ",v_event_sid="   + getObjectFirst("v_event_sid").value
                         + ",v_m_rsv_sid="   + getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "M_RSV_SID")
                         + ",v_m_rsv_sid2="  + getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "M_RSV_SID")
                         + ",v_manage_no="+s_manage_no;
             
             //alert("�߰���ư");
             //alert(v_param);
             ln_TRSetting(tr_temp, 
                 dirPath + servletPath + "Rv200I_N_biz",
                 "JSP(O:CUST_TEMP=ds_cust_temp, O:CUST_RESULT=ds_cust_result)",
                 v_param);
             tr_post(tr_temp);
         }

         // ������ �߰�- ���� ��� â���� ����Ŭ���� ��.
         function fnTourCust(dirPath, servletPath){
             var max_person = eval(getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "MAX_PERSONS"));
             
             var cust_cnt = eval(getObjectFirst("ds_cust").CountRow);

             var s_manage_no = getObjectFirst("ds_tour").NameValue(getObjectFirst("ds_tour").RowPosition, "MANAGE_NO");
             if(max_person<cust_cnt){
                 alert("�ִ� �ο��� �ʰ��߽��ϴ�.");
                 return;
             }
             
             for(var i=1; i<=getObjectFirst("ds_cust").CountRow; i++){
                 if(getObjectFirst("ds_cust").NameValue(i, "MANAGE_NO")==s_manage_no){
                     alert("�̹� ��ϵ� ����� �����Դϴ�.");
                     return;
                 }
             }
             //alert("�������� ����Ŭ��");
             //alert(tr_temp);
             var v_param = "proType=S"
                         + ",v_business="    + v_business.ValueOfIndex("SAUP_SID", v_business.Index)
                         + ",v_accept_sid="  + getObjectFirst("v_accept_sid").value
                         + ",v_client_sid="  + getObjectFirst("v_client_sid").value
                         + ",v_depart_date=" + getObjectFirst("v_depart_date").Text
                         + ",v_depart_time=" + getObjectFirst("v_depart_time").Text
                         + ",v_nights="      + getObjectFirst("v_nights").value
                         + ",v_goods_sid="   + getObjectFirst("ds_search").NameValue(getObjectFirst("ds_search").RowPosition, "GOODS_SID")
                         + ",v_blockType="   + v_blockType.ValueOfIndex ("DETAIL", v_blockType.Index)
                         + ",v_roomType="    + v_roomType.ValueOfIndex ("ROOM_TYPE_SID", v_roomType.Index)
                         + ",v_block_sid="   + getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "BLOCK_SID")
                         + ",v_room_sid="    + getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "ROOM_SID")
                         + ",v_arrive_date=" + getObjectFirst("v_arrive_date").Text
                         + ",v_arrive_time=" + getObjectFirst("v_arrive_time").Text
                         + ",v_event_sid="   + getObjectFirst("v_event_sid").value
                         + ",v_rsv_sid="     + getObjectFirst("ds_tour").NameValue(getObjectFirst("ds_tour").RowPosition, "RSV_SID")
                         + ",v_m_rsv_sid="   + getObjectFirst("ds_tour").NameValue(getObjectFirst("ds_tour").RowPosition, "M_RSV_SID")
                         + ",v_manage_no="   + getObjectFirst("ds_tour").NameValue(getObjectFirst("ds_tour").RowPosition, "MANAGE_NO");
             ln_TRSetting(tr_temp, 
                 dirPath + servletPath + "Rv200I_N_biz",
                 "JSP(O:CUST_TEMP=ds_cust_temp, O:CUST_RESULT=ds_cust_result)",
                 v_param);
             tr_post(tr_temp);
         }
         
         /**
          * ������ ����
          */
         function fnCustDel(dirPath, servletPath){
             getObjectFirst("ds_cust").DeleteRow(getObjectFirst("ds_cust").RowPosition);
             getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "RSV_PERSONS") = getObjectFirst("ds_cust").CountRow;
         }
         
         /**
          * ������ �߰� ��� : ���� ����� ����. ���� �÷��� �޶��... 2020-02-23
          * ������ ���� �� ������ ������ �ٽ� �ѹ� ��ȸ�Ѵ�.
          */
         function fnCustSave(dirPath, servletPath){
             if(getObjectFirst("ds_cust").IsUpdated){
                 var join_cd_cnt = 0;
                 if(getObjectFirst("ds_cust").CountRow>0){
     	            for(var i=1; i<=getObjectFirst("ds_cust").CountRow; i++){
     	                if(getObjectFirst("ds_cust").NameValue(i, "JOIN_CD")=="01"){//����
     	                    join_cd_cnt++;
     	                }
     	            }
     	            
     	            if(join_cd_cnt==0){
     	                alert("������ �� ����(����)�� ���õǾ�� �մϴ�.");
                         return;
     	            }
     	            
     	            if(join_cd_cnt>1){
     	                alert("����(����)�� �Ѹ� ������ �� �ֽ��ϴ�.");
                         return;
     	            }
                 }
                 
     	        var v_param = "proType=A"
     	                    + ",v_business="    + v_business.ValueOfIndex("SAUP_SID", v_business.Index)
                             + ",v_accept_sid="  + getObjectFirst("v_accept_sid").value
                             + ",v_accept_no="   + getObjectFirst("v_accept_no").Text
     	                    + ",v_client_sid="  + getObjectFirst("v_client_sid").value
     	                    + ",v_depart_date=" + getObjectFirst("v_depart_date").Text
     	                    + ",v_depart_time=" + getObjectFirst("v_depart_time").Text
     	                    + ",v_nights="      + getObjectFirst("v_nights").value
     	                    + ",v_goods_sid="   + getObjectFirst("ds_search").NameValue(getObjectFirst("ds_search").RowPosition, "GOODS_SID")
     	                    + ",v_blockType="   + v_blockType.ValueOfIndex ("DETAIL", v_blockType.Index)
     	                    + ",v_roomType="    + v_roomType.ValueOfIndex ("ROOM_TYPE_SID", v_roomType.Index)
     	                    + ",v_block_sid="   + getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "BLOCK_SID")
     	                    + ",v_room_sid="    + getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "ROOM_SID")
     	                    + ",v_arrive_date=" + getObjectFirst("v_arrive_date").Text
     	                    + ",v_arrive_time=" + getObjectFirst("v_arrive_time").Text
     	                    + ",v_event_sid="   + getObjectFirst("v_event_sid").value
     	                    + ",v_m_rsv_sid="   + getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "M_RSV_SID")
                             + ",v_bound_seq="   + 1; //getObjectFirst("v_bound_seq").Text;
     //alert(v_param);
     	        ln_TRSetting(tr_save, 
     	            dirPath + servletPath + "Rv200I_N_biz",
     	            "JSP(I:REG_CUST=ds_cust,O:SAVE_RESULT=ds_cust_result)",
     	            v_param);
     	        tr_post(tr_save);
             } else {
                 alert("����� ������ �����ϴ�.");
                 return;
             }
         }
         
         /**
          * ���� ����
          */
         function fnCustDisplay(v_country){
     /*        if(v_country=="" || v_country=="10"){
                 for(var i=0; i<getObjectList("inner_person").length; i++)
                     getObjectList("inner_person")[i].style.display = "inline";
                 for(var i=0; i<getObjectList("outer_person").length; i++)
                     getObjectList("outer_person")[i].style.display = "none";
             } else {
                 for(var i=0; i<getObjectList("inner_person").length; i++)
                     getObjectList("inner_person")[i].style.display = "none";
                 for(var i=0; i<getObjectList("outer_person").length; i++)
                     getObjectList("outer_person")[i].style.display = "inline";
             }

             if(ds1.CountRow>0){
                 getObjectFirst("cust_save_btn").style.display = "inline";
                 getObjectFirst("cust_cancel_btn").style.display = "inline";
                 getObjectFirst("cust_reset_btn").style.display = "inline";
                 
                 getObjectFirst("zipcode_btn").style.display = "inline";
                 getObjectFirst("country_btn").style.display = "inline";
                 getObjectFirst("nation_btn").style.display = "inline";

                 getObjectFirst("regi_no").Enable   = "False";
                 getObjectFirst("pass_no").Enable   = "False";
//                 getObjectFirst("lc_country_gu").Enable   = "False";
                 getObjectFirst("lc_pass_type").Enable   = "True";
                 getObjectFirst("pass_expire_date").Enable= "True";
                 getObjectFirst("birthday").Enable       = "True";
              
                 getObjectFirst("zip_cd").Enable         = "True";
                 getObjectFirst("eng_company_nm").Enable = "True";
                 getObjectFirst("eng_position").Enable   = "True";
                 getObjectFirst("country_cd").Enable     = "True";
                 getObjectFirst("lc_nation").Enable      = "True";
                 getObjectFirst("txt_company_nm").readOnly     = false;
                 getObjectFirst("txt_positions").readOnly      = false;
                 getObjectFirst("txt_cust_nm").readOnly      = false;
                 getObjectFirst("txt_address1").readOnly      = false;
                 getObjectFirst("txt_address2").readOnly      = false;
                 getObjectFirst("txt_eng_addr1").readOnly      = false;
             } else {
                 getObjectFirst("cust_save_btn").style.display = "none";
                 getObjectFirst("cust_cancel_btn").style.display = "none";
                 getObjectFirst("cust_reset_btn").style.display = "inline";
                 
                 getObjectFirst("zipcode_btn").style.display = "none";
                 getObjectFirst("country_btn").style.display = "none";
                 getObjectFirst("nation_btn").style.display = "none";
              
                 getObjectFirst("lc_country_gu").Enable  = "True";
                 getObjectFirst("regi_no").Enable        = "True";
                 getObjectFirst("pass_no").Enable        = "True";
                 getObjectFirst("lc_pass_type").Enable   = "False";
                 getObjectFirst("pass_expire_date").Enable= "False";
                 getObjectFirst("birthday").Enable       = "False";
                 getObjectFirst("zip_cd").Enable         = "False";
                 getObjectFirst("eng_company_nm").Enable = "False";
                 getObjectFirst("eng_position").Enable   = "False";
                 getObjectFirst("country_cd").Enable     = "False";
                 getObjectFirst("lc_nation").Enable      = "False";
                 getObjectFirst("txt_company_nm").readOnly     = true;
                 getObjectFirst("txt_positions").readOnly      = true;
                 getObjectFirst("txt_cust_nm").readOnly      = true;
                 getObjectFirst("txt_address1").readOnly      = true;
                 getObjectFirst("txt_address2").readOnly      = true;
                 getObjectFirst("txt_eng_addr1").readOnly      = true;
             }*/
         }

         /**
          * �����ȣ �˾�
          */
         function fnZipCodePopupRv(dirPath) {
             var arrParam    = new Array();
             var arrResult   = new Array();
             var strURL; 
             var strPos;
                 
             strURL = dirPath+"/Sales/help/sy002h.jsp";
             strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
             arrResult = showModalDialog(strURL,arrParam,strPos);    
         
             if (arrResult != null) {
                 arrParam = arrResult.split(";");
                 zip_cd.Text= arrParam[0];
                 txt_address1.value = arrParam[1];
             }       
         }

         
         /**
          * ��ü��� �˾�
          */
         function fnGroupPopup(dirPath){
             var arrResult   = new Array();
             arrResult = fnGroupPop(dirPath);
             if (arrResult != null) {
                 arrParam = arrResult.split(";");
                 getObjectFirst("v_event_sid").value = arrParam[0];
                 getObjectFirst("v_event_nm").value 	= arrParam[1];
                 getObjectFirst("v_event_no").value	= arrParam[2];
                 
     			//fnAcceptNo(dirPath, servletPath);
             }
         }
         
         //��ǰ���� ������ Ŭ��
         function fnSeqNext(){
     /*    	var total_seq 	= parseInt(v_bound_total_seq.text);	//��Ż
         	var seq 		= parseInt(v_bound_seq.text);		//����
         	var nextseq 	= parseInt(v_bound_seq.text)+1;		//���� �� �̸� �ϴ� ������ ����.

     		if(seq < total_seq){	//��Ż���� ������ ����seq ȣ��
     	    	alert("next");
     	    	//ds_search�� ���� ��������?

     	        var v_param = "proType=S"
                             + ",v_business="+v_business.ValueOfIndex("SAUP_SID", v_business.Index)
     	                    + ",v_accept_no="+getObjectFirst("v_accept_no").Text.trim()
                             + ",v_client_sid="+ getObjectFirst("v_client_sid").value
                             + ",v_bound_seq="+ nextseq;
     			alert(v_param);
     	        ln_TRSetting(tr_search,
     	                    "/servlet/sales.menu.rv.Rv200I",
     	                    "JSP(O:SEARCH=ds_search)",
     	                    v_param);
     	        tr_post(tr_search);

         	}
         	
         	//2. �ű�*/
         }
         
         
         
         //��ǰ���� ����   Ŭ��
         function fnSeqPrev(){
//         	alert("prev");
         	//1. ������
         	//2. �ű� �� ����.
         }
         




         
     // �������� �߰�  20100212 �ɵ���********************************************************
     	function fnCarAdd(){
     		if(!getObjectFirst("v_accept_sid").value){
     			alert("��û����ȣ�� �����ϴ�.\n\n��û����ȣ �Է�|�˻� ��\n������ �߰��Ͻ� �� �ֽ��ϴ�.");
     			return;
     		}
     		if(v_bound_seq.text == "" || v_bound_seq.text=="0" || v_bound_seq.text == null){ //Ȥ�ó� üũ
     			alert("��ǰ������ �����ϴ�.\n���� 1ȸ ���� �� ������ �߰��Ͻ� �� �ֽ��ϴ�.");
     			return;
     		}
     		if(v_depart_date.text == "" || v_depart_date.text.length < 8){ //�������
     			alert("������ڸ� �Է����ּ���.\n�������, ��ǰ ���� �� ������ �߰��Ͻ� �� �ֽ��ϴ�.");
     			return;
     		}
     		if(v_depart_time.text == "" || v_depart_time.text.length < 4){ //�������
     			alert("��߽ð��� �����ϴ�.\n��ǰ ������ ���� �ʾҰų�, �ش� ��ǰ�� ��߽ð��� �����Ǿ����ϴ�.\n\n�������, ��ǰ ���� �� ������ �߰��Ͻ� �� �ֽ��ϴ�.");
     			return;
     		}
     		
     		
     		ds_car.AddRow();
     		ds_car.namevalue(ds_car.rowposition,"client_sid") = getObjectFirst("v_client_sid").value;
     		ds_car.namevalue(ds_car.rowposition,"accept_sid") = getObjectFirst("v_accept_sid").value;
     		ds_car.namevalue(ds_car.rowposition,"depart_date") = v_depart_date.text;
     		ds_car.namevalue(ds_car.rowposition,"depart_time") = v_depart_time.text;
     		ds_car.namevalue(ds_car.rowposition,"arrive_date") = v_arrive_date.text;
     		ds_car.namevalue(ds_car.rowposition,"arrive_time") = v_arrive_time.text;
     		ds_car.namevalue(ds_car.rowposition,"bound_seq") = v_bound_seq.text;

         };
         

         // ������� ����
         function fnCarSave(dirPath, servletPath){
             if(getObjectFirst("ds_car").IsUpdated){
     	        var v_param = "proType=A"
     	                    + ",v_accept_sid="+getObjectFirst("v_accept_sid").value;
     	        ln_TRSetting(tr_save, 
     	                    dirPath + servletPath + "Rv200I_N_biz",
     	                    "JSP(I:REG_CAR=ds_car)",
     	                    v_param);
     	        tr_post(tr_save);

             } else {
                 alert("������ܿ� ����� ������ �����ϴ�.");
                 return;
             }
         }
     	
     	//���� �׸��� ����
     	function fnCarDel(dirPath, servletPath){
     		ds_car.DeleteRow(ds_car.RowPosition);
     	}

     	//���� ���
     	function fnCarCancel() {
     	 	ds_car.UndoAll();
     	}

         // ������� ��ȸ
         function fnGetCar(dirPath, servletPath){
             var v_param = "proType=S"
                         + ",v_accept_sid="+getObjectFirst("v_accept_sid").value
                         + ",v_bound_seq="+ v_bound_seq.text;
             ln_TRSetting(tr1, 
                         dirPath + servletPath+"Rv200I_N_biz",
                         "JSP(O:CAR=ds_car)",
                         v_param);
             tr_post(tr1);
         }

     	// ���� �˾�
     	function fnCarPopup(dirPath, servletPath) {
     		var arrParam	= new Array();
     		var arrResult	= new Array();
     		var strURL;	 
     		var strPos;
     			
     		arrParam[0] = getObjectFirst("v_client_sid").value;;
     		arrParam[1] = getObjectFirst("v_client_nm").value;;
     		
     		strURL = dirPath+"/Sales/help/rv002h.jsp";
     		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
     		arrResult = showModalDialog(strURL,arrParam,strPos);	

     		if (arrResult != null) {
     			arrParam = arrResult.split(";");
     	   		ds_car.namevalue(ds_car.rowposition, "car_sid")  = arrParam[0];
     	   		ds_car.namevalue(ds_car.rowposition, "car_no")   = arrParam[1];
     	   		ds_car.namevalue(ds_car.rowposition, "car_nm")   = arrParam[2];
     	   		ds_car.namevalue(ds_car.rowposition, "car_type") = arrParam[3];

     	   		
        			for (row = 1; row < ds_car.countrow; row++) {
        				if (ds_car.namevalue(row,"car_sid") == arrParam[0]) {
        					alert("���� ������ �ߺ� ����� �� �����ϴ�!");
        					
        					ds_car.namevalue(ds_car.rowposition,"car_sid") = "";
     			   		ds_car.namevalue(ds_car.rowposition,"car_no") = "";
     			   		ds_car.namevalue(ds_car.rowposition,"car_nm") = "";
     			   		ds_car.namevalue(ds_car.rowposition,"car_type") = "";
     	   		
        					return;
        				}
        			}
     		} else {
        					ds_car.namevalue(ds_car.rowposition,"car_sid") = "";
     			   		ds_car.namevalue(ds_car.rowposition,"car_no") = "";
     			   		ds_car.namevalue(ds_car.rowposition,"car_nm") = "";
     			   		ds_car.namevalue(ds_car.rowposition,"car_type") = "";
     		}				
     	}		    

     // �������� �� 20100212 �ɵ���********************************************************
         

     	// �޷� �˾� (���� �޷¼ҽ� �̿�.. �ٸ� �͵�� �ٸ��� �Ķ���͸� �̸� �迭�� ������.
     	function fnCalPopup(dirPath,servletPath){
             var arrResult   = new Array();
             arrResult = fnCalPop(dirPath);
             if (arrResult != null) {
                 //alert(arrResult[3]);//��,��,��, ����� ����
                 if(arrResult[3] < v_depart_date.text){
                 	alert("�������ڴ� ������ں��� ���ų� Ŀ�� �մϴ�.\n\n�ٽ� ������ �ֽñ� �ٶ��ϴ�.");
                 }else{
     		   		ds_cust.namevalue(ds_cust.rowposition, "ARRIVE_DATE")  = arrResult[3];
     		   	}
             }
         }
         
         
         
     // �ο��߰��� �˻� �� : ����ڸ� �߰� 2010-04-01
     		function fnCustPopup(dirPath) {
     	        if(getObjectFirst("v_client_nm").value==""){
     	            alert("���¾�ü�� ���� �����Ͻñ� �ٶ��ϴ�.");
     	            return;
     	        }

     			var arrParam	= new Array();
     			var arrResult	= new Array();
     			var strURL;	 
     			var strPos;
     			
     			strURL = dirPath+"/Sales/help/rv004h.jsp?sClientSid="+getObjectFirst("v_client_sid").value+"&sClientNm=";
     			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
     			arrResult = showModalDialog(strURL,arrParam,strPos);
     		
     			if (arrResult != null) {
     				arrParam = arrResult.split(";");
     	            getObjectFirst("v_manage_no").Text = arrParam[2];
     			} else {
     	            getObjectFirst("v_manage_no").Text = "";
     	        }
     		}
     		
     		
     //�԰�ð� ���� �θ��� : tr_search Ʈ����� ������ ȣ��
     	//����RM015
     	function fnResetArrTime(dirPath,servletPath){
     		var param1;
     		if(1==v_business.ValueOfIndex("SAUP_SID", v_business.Index)){
     			param1 = "&s_item4=Y";		//		�ݰ��� �ð��� :
     		} else if(2==v_business.ValueOfIndex("SAUP_SID", v_business.Index)) {
     			param1 = "&s_item5=Y";		//		��  �� �ð���
     		}
     		
     		//����� �ð��� :item3=Y
     		init_arrTimeDs.dataId = dirPath+servletPath+"Sy001H?dsType=2&proType=S&s_Head=RM015&s_item1=Y&s_item3=Y"+ param1;
     		init_arrTimeDs.Reset();
     	}
     	
        
        
    </script>
<%
/*=============================================================================
            DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row)">
    if(Row<1) return;
</script>
<script language="javascript" for="tr1" event="OnSuccess()">
//�⺻ �ε��Ҷ�.. �ϴ� �ѹ� ���˴ϴ�.
//��ǰ�˻��� ��
//����Ÿ�� ���� �� �ܿ����Ǽ� ����Ʈ ǥ���� ��
//���� ����Ʈ���� �����ؼ� �����ο� ��ȸ�� ��
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    var info_cnt = tr1.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert(info_msg);

	if(v_cust_flag == "S_cust"){	// ���� ������ �ο����� �ҷ��� ��.
        var v_goods_sid = v_goods_nm.ValueOfIndex("GOODS_SID", v_goods_nm.Index);
        if(v_goods_sid==50){	//���ݰ� ��ǰ�̸�
        	//���⼭ ������ ���ƾ� �� �� ���⵵ �ѵ�.. �¼����� �̺�Ʈ�� �̿��ϴ°� ����..
			lc_theme.index = 1;	//�׸��ڵ���� ���ݰ� �⺻���� --------------------------------------------
        };
	};   
//	alert("175����");        
</script>

<script language="javascript" for="tr1" event="OnFail()">
	fnHideLoading();
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_search" event="OnSuccess()">
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    var info_cnt = tr_search.SrvErrCount("INFO");
    var info_msg = "";
    for(var i=0; i<info_cnt; i++){
        info_msg += tr_search.SrvErrMsg("INFO", i) + "\n";
    }
    if(info_msg!="") 
        alert(info_msg);
//	alert("205����"); 	//������� �˻��ϸ� ��� 

	//�԰�ð� ����! 2010-04-22

	fnResetArrTime("<%=dirPath%>","<%=HDConstant.PATH_HELP%>");
</script>

<script language="javascript" for="tr_search" event="OnFail()">
	fnHideLoading();
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_search.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_search.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_search.ErrorCode + "\n" + "Error Message : " + tr_search.ErrorMsg + "\n");
//	alert("221����");                
</script>

<script language="javascript" for="tr_temp" event="OnSuccess()">
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    var info_cnt = tr_temp.SrvErrCount("INFO");
    var info_msg = "";

    for(var i=1; i<=ds_cust_result.CountRow; i++){
        if(ds_cust_result.NameValue(i, "S_YN")=="Y"){
            if(ds_cust_result.NameValue(i, "MSG_CD")!="0000"){
                alert(ds_cust_result.NameValue(i, "MSG"));
				//alert("235����");
            }
        } else {
            alert(ds_cust_result.NameValue(i, "MSG"));
            	//alert("239����");        
            getObjectFirst("ds_cust_temp").ClearAll();
            getObjectFirst("ds_cust_result").ClearAll();
            return;
        }
    }
    
    if(getObjectFirst("ds_cust_temp").CountRow==0){
        if(v_manage_no.Text!=""){
            alert("�ֹ�/���ǵ�Ϲ�ȣ : "+ v_manage_no.Text +" �� ����ڴ� �������� �ʽ��ϴ�.");
            getObjectFirst("v_manage_no").Focus();
        } else {
            alert("�ֹ�/���ǵ�Ϲ�ȣ : "+ ds_tour.NameValue(ds_tour.RowPosition, "MANAGE_NO") +" �� ����ڴ� �������� �ʽ��ϴ�.");
        }
        getObjectFirst("ds_cust_temp").ClearAll();
        getObjectFirst("ds_cust_result").ClearAll();
        	//alert("255����");        
        return;
    }
    
    var max_person = eval(getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "MAX_PERSONS"));
    var cust_cnt = getObjectFirst("ds_cust").CountRow;
    
    if(max_person<(Number(cust_cnt)+Number(getObjectFirst("ds_cust_temp").CountRow))){
        alert("�ִ� �ο��� �ʰ��߽��ϴ�. ["+ (Number(cust_cnt)+Number(getObjectFirst("ds_cust_temp").CountRow)) +"]");
        return;
    }
    
    
    /*
     * �ű� �߰��� ds_cust �� �������� �����ϸ�, ������ �ٸ� ����ڴ� �������� �з��Ѵ�.
     * 2006. 09. 18 ������� ��û����
     * modifier : �迵��
     */
    var v_bonin_gubn = "01";	//����
    
    for(var i=1; i<=getObjectFirst("ds_cust_temp").CountRow; i++){
    	if(getObjectFirst("ds_cust").CountRow>0)
    		v_bonin_gubn = "02";	//����
    		
        getObjectFirst("ds_cust").AddRow();
        
        for(var j=1; j<=getObjectFirst("ds_cust_temp").CountColumn; j++)
            getObjectFirst("ds_cust").ColumnString(getObjectFirst("ds_cust").RowPosition, j) = getObjectFirst("ds_cust_temp").ColumnString(i, j);
        
        getObjectFirst("ds_cust").NameValue(getObjectFirst("ds_cust").RowPosition, "JOIN_CD")  = v_bonin_gubn;
        
        for(var j=1; j<=getObjectFirst("ds_tour").CountRow; j++){
            if(getObjectFirst("ds_tour").NameValue(j, "MANAGE_NO") == getObjectFirst("ds_cust_temp").NameValue(i, "MANAGE_NO") && getObjectFirst("ds_cust").CountRow>0){
                getObjectFirst("ds_tour").NameValue(j, "MOVE_TEMP")="M";//�̵�����
            }
        }

    }

//    if(getObjectFirst("ds_cust_temp").NameValue(1, "COUNTRY_GU")=="10")
//        getObjectFirst("regi_no").Text = getObjectFirst("ds_cust_temp").NameValue(1, "MANAGE_NO");
//    else
//        getObjectFirst("pass_no").Text = getObjectFirst("ds_cust_temp").NameValue(1, "MANAGE_NO");

    getObjectFirst("ds_cust_temp").ClearAll();
    getObjectFirst("ds_cust_result").ClearAll();
    
    getObjectFirst("ds_block").NameValue(getObjectFirst("ds_block").RowPosition, "RSV_PERSONS") = getObjectFirst("ds_cust").CountRow;
    fnCustInfoChange();
    
    getObjectFirst("v_manage_no").Text = "";

</script>

<script language="javascript" for="tr_temp" event="OnFail()">
//������ �߰��� �� ����ϴ� TR������Ʈ�� OnFail �̺�Ʈ.
//������ �߻��� ��� �Ʒ����� �޼����� ����ش�.
	fnHideLoading();
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";
    var error_cnt = tr_temp.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_temp.SrvErrMsg("ERROR", i)+"\n";
    }

    if(error_msg!="") {
        alert(error_msg);
    } else {
        alert("Error Code : " + tr_temp.ErrorCode + "\n" + "Error Message : " + tr_temp.ErrorMsg + "\n");
    }
//	alert("324����");                
</script>

<script language="javascript" for="tr_cust" event="OnSuccess()">
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    alert("����Ǿ����ϴ�.");
    v_cust_flag = "";
    //getObjectFirst("v_manage_no").Text = getObjectFirst("ds1").NameValue(getObjectFirst("ds1").RowPosition, "MANAGE_NO");
</script>

<script language="javascript" for="tr_cust" event="OnFail()">
	fnHideLoading();
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_cust.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_cust.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="" && error_msg!=null) 
        alert(error_msg);
    else
        alert("Error Code : " + tr_cust.ErrorCode + "\n" + "Error Message : " + tr_cust.ErrorMsg + "\n");
//	alert("349����");
</script>

<script language="javascript" for="tr_save" event="OnSuccess()">
    /**
     * ds_cust_result(����������), ds_room_result(������������), ds_amt_result(�ǸŰ� ���)
     * ����� ó���ϸ� Display �Ѵ�.
     */
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_DONE%>";
	//fnHideLoading();
    
    var total_result_msg    = "";     //��ü �޽��� ó�� ���
    var cust_result_msg     = "";     //���������� ���� ���
    var option_result_msg   = "";     //�ɼ����� ���� ���
    var room_result_msg     = "";     //������������ ���� ���
    var amt_result_msg      = "";     //�ǸŰ� ��� ���� ���
    
    var var_accept_no       = "";     //������ ó���� accept_no
    var var_accept_sid      = "";     //�� ���� ó���� accept_sid
    
    if(ds_cust_result.CountRow>0){
        for(var i=1; i<=ds_cust_result.CountRow; i++){
            if(ds_cust_result.NameValue(i, "MSG_CD")!="0000"){
                cust_result_msg += "["+ ds_cust_result.NameValue(i, "MANAGE_NO") + "] ó�����["
                                + ds_cust_result.NameValue(i, "MSG")+"]\n";
            }
            
            var_accept_no = ds_cust_result.NameValue(i, "ACCEPT_NO");
            var_accept_sid = ds_cust_result.NameValue(i, "ACCEPT_SID");
        }
        if(cust_result_msg!="" && cust_result_msg!=null)
            total_result_msg += "������ ���� ����� ó����� \n\n"+cust_result_msg+"\n";
    }
    if(ds_room_result.CountRow>0){
        var v_room_flag = false;
        for(var i=1; i<=ds_room_result.CountRow; i++){
            if(ds_room_result.NameValue(i, "MSG_CD")!="0000"){
                room_result_msg += ds_room_result.NameValue(i, "MSG")+"\n";
            } else v_room_flag = true;
        }
        
        ds_room_result.ClearAll();
        
        if(room_result_msg!="" && room_result_msg!=null)
            total_result_msg += "������������ ����� ó����� \n\n"+room_result_msg+"\n";
            
        if(v_room_flag){
            fnRoomType("<%=dirPath%>", "<%=HDConstant.PATH_RV%>");
            fnGetTour("<%=dirPath%>", "<%=HDConstant.PATH_RV%>");
	        fnGetCar('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
        }
    }
    if(ds_amt_result.CountRow>0){
        for(var i=1; i<=ds_amt_result.CountRow; i++){
            if(ds_amt_result.NameValue(i, "MSG_CD")!="0000"){
                amt_result_msg += ds_amt_result.NameValue(i, "MSG")+"\n";
            }
        }
        if(amt_result_msg!="" && amt_result_msg!=null)
            amt_result_msg += "�ǸŰ���� ����� ó����� \n\n"+amt_result_msg+"\n";
    }

    if(amt_result_msg!="" && amt_result_msg!=null)
        alert(amt_result_msg);
    else
        alert("����Ǿ����ϴ�.");
    
    //������ ���� ���� ������ �� ���� �� 
    if(ds_cust_result.CountRow>0){
        if(var_accept_no != null && var_accept_no != ""){
        	//alert("1");
            v_accept_no.Text = var_accept_no;
            v_accept_sid.value = var_accept_sid;
            fnAcceptNoAfter('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
            fnRoomType('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
            
            v_block_row = ds_block.RowPosition;
        }
        fnGetDataCust('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
        fnGetTour('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
    } else if(ds_amt_result.CountRow>0){
        fnGetTour('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
    }
    
    ds_amt_result.ClearAll();
    ds_cust_result.ClearAll();
    getObjectFirst("v_manage_no").Text = "";
</script>

<script language="javascript" for="tr_save" event="OnFail()">
	fnHideLoading();
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_ERR%>";

    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
//alert("tr_save OnFail : " + error_cnt);
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
//	alert("450����");        
</script>

<script language=javascript for="ds_search" event="OnLoadCompleted(row)">
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    if(row==0){	//��.. ��ȸ����� ���� !
        alert("<%=HDConstant.S_MSG_NO_DATA%>");

        var temp_data = "";
        if(v_function=="ACCEPT"){
            temp_data = getObjectFirst("v_accept_no").Text;
            v_function = "RESET";
            fnDataSetClear();
            getObjectFirst("v_accept_no").Text = temp_data;
            //getObjectFirst("v_accept_no").Focus();
        } else if(v_function == "DEPART_DATE"){
            temp_data = getObjectFirst("v_depart_date").Text;
            v_function = "RESET";
            fnDataSetClear();
            getObjectFirst("v_depart_date").Text = temp_data;
            //getObjectFirst("v_depart_date").Focus();
        }
        return;
    }

    fnSearchDataChange();	// ��ȸ �����Ϳ� ���� ��Ʈ�� ����
    fnSearchEnd(row);		// ds_search OnLoadCompleted Event
    if(v_accept_sid.value!="") {
        fnGetTour('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
        fnGetCar('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
	}
</script>

<script language=javascript for="ds1" event="OnLoadCompleted(row)">
    msgTxt.innerHTML= "<%=HDConstant.S_MSG_SAVE_DONE%>";
	fnHideLoading();

    if(v_cust_flag=="S"){
        if(row==0) {
            alert("<%=HDConstant.S_MSG_NO_DATA%>");
            fnCancelCust();
        }
    }
</script>

<script language=javascript for="ds_cust" event="OnLoadCompleted(row)">
    fnCustButtonChange();
    fnCustInfoChange();
</script>

<script language=javascript for="ds_block" event="OnLoadCompleted(row)">
    if(row==0){
        //alert("��� �� �������� �����Ͱ� �������� �ʽ��ϴ�.");
        //return false;
    }
//alert("ds_block : " + ds_block.RowPosition + " v_block_row : "+ v_block_row);
    ds_block.RowPosition = v_block_row;
    if(v_function!="ROOM"){
        fnGetDataCust('<%=dirPath%>','<%=HDConstant.PATH_RV%>');
    }
</script>

<script language=javascript for=v_accept_no event="OnKillFocus()">	<%//��û����ȣ �Է��� �������� ��%>
    fnAcceptNo("<%=dirPath%>", "<%=HDConstant.PATH_RV%>");
</script>
<script language=javascript for=v_depart_date event="OnKillFocus()"> <%//������� �Է� �� �������� ��%>
    fnDepartDate("<%=dirPath%>", "<%=HDConstant.PATH_RV%>");
</script>
<script language=javascript for="v_goods_nm" event="OnSelChange()">
    if(getObjectFirst("ds_search").CountRow<=1 || v_cust_flag=="") return;
    setTimeout("fnRoomType('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')", 200);
</script>
<script language=javascript for="v_bound" event="OnSelChange()">	<%//bound �������� ��%>
    fnBound('<%=dirPath%>', '<%=HDConstant.PATH_HELP%>');
</script>
<script language=javascript for="v_blockType" event="OnSelChange()">
    if(getObjectFirst("init_blockTypeDs").CountRow==0 || v_cust_flag=="") return;
    setTimeout("fnBlockType('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')", 200);
</script>
<script language=javascript for="v_roomType" event="OnSelChange()">
    if(getObjectFirst("ds_room").CountRow==0 || v_cust_flag=="") return;
    
    v_block_row = 0;
    setTimeout("fnRoomType('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')", 200);
</script>

<script language=javascript for="gr_block" event="OnClick(Row, Colid)">
    if(Row==0) return;

    if(getObjectFirst("ds_cust").IsUpdated){
        if(getObjectFirst("ds_block").RowPosition != v_block_row)
            alert("������ ��ܿ� ������� ���� �����Դϴ�.\n\n���� ������ ��� ������ �Ͻñ� �ٶ��ϴ�.");
        getObjectFirst("ds_block").RowPosition = v_block_row;
        return;
    }
    //alert("1");
    getObjectFirst("photo").src = "<%=dirPath%>/Sales/images/00000.gif";
    //alert("2");
    v_block_row = Row;
    //alert("3");
    setTimeout("fnGetDataCust('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')", 200);

    //alert("4"); 
    gr_cust.Focus();
</script>

<script language=JavaScript for=gr_carlist event=OnPopup(row,colid,data)>
	if(colid=="car_nm") {                            
		fnCarPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');   
	}            
</script>

<script language=JavaScript for=gr_cust event=OnPopup(row,colid,data)>
	if(colid=="DUMMY_COL") {
		fnCalPopup('<%=dirPath%>', row);
	}
</script>

<script language=JavaScript for=gr_cust event=OnCloseUp(row,colid)>
	if (colid=="CUST_TYPE") {
		if(172==ds_cust.NameValue(row, colid)) { //������ = "����"
			alert("���ָ� �����Ͻø� �������ڰ� ���� ���Ϸ� �ڵ� ����˴ϴ�.");
			var today = new Date();
			var yyyy = today.getYear();
			var newArrDate = (yyyy+1) +"1231";
			ds_cust.NameValue(row, "ARRIVE_DATE")=newArrDate;
		}
	}
</script>









<script language=JavaScript  for=ds_cust event="OnRowPosChanged(Row)">
    fnResetCust();
//    fnCustDisplay(ds_cust.NameValue(Row, "COUNTRY_GU"));
    getObjectFirst("ds1").ClearAll();
    if(Row==0) return;
    
    for(var i=1; i<=initds1.CountRow; i++){
        if(initds1.NameValue(i, "DETAIL")==ds_cust.NameValue(Row, "COUNTRY_GU")){
            initds1.RowPosition = i;
        }
    }
//    if(ds_cust.NameValue(Row, "COUNTRY_GU") == "10")
//        regi_no.Text = ds_cust.NameValue(Row, "MANAGE_NO");
//    else
//        pass_no.Text = ds_cust.NameValue(Row, "MANAGE_NO");
    
    v_cust_row = Row;
//    photo.src = "http://erp.hdasan.com/services/Sales/file/photo/cust/"+ ds_cust.NameValue(Row, "MANAGE_NO") +".JPG";
    photo.src = "http://203.242.32.42/photos/cust/"+ds_cust.NameValue(Row,"MANAGE_NO").substring(0,1)+"/"+ ds_cust.NameValue(Row, "MANAGE_NO") +".JPG";

    

// ���λ� �߰� - ������ �ȵǴ� �ڵ� Ŀ�� ���� 2007-05-11 by �ɵ���
	//����
//	index=lc_jeju.IndexOfColumn("detail", ds_cust.namevalue(ds_cust.Rowposition,"jeju_yn"));
//	lc_jeju.index=index;
	//�ָ�
//	index=lc_weekend.IndexOfColumn("detail", ds_cust.namevalue(ds_cust.Rowposition,"weekend_yn"));
//	lc_weekend.index=index;
	
	
</script>

<script language=JavaScript  for=gr_tourlist event="OnDblClick(Row, Colid)">
    if(Row==0) return;
    
    if(ds_block.CountRow==0){
        alert("��� ������ ���� ��ȸ �� Ŭ���Ͻñ� �ٶ��ϴ�.");
        return;
    }
    if(ds_cust.CountRow==0){
        ds_cust.AddRow();
        if(ds_cust.CountRow==0){
            alert("������ ������ ���� ��ȸ �� Ŭ���Ͻñ� �ٶ��ϴ�.");
            return;
        } else {
            ds_cust.DeleteRow(ds_cust.CountRow);
        }
    }
    fnTourCust('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');
</script>

<script language=JavaScript  for=gr_tourlist event=onKeyPress(keycode)>
  			
    if (keycode == 13) {
	    if(ds_tour.CountRow==0) return;
	    
	    if(ds_block.CountRow==0){
	        alert("��� ������ ���� ��ȸ �� Ŭ���Ͻñ� �ٶ��ϴ�.");
	        return;
	    }
	    if(ds_cust.CountRow==0){
	        ds_cust.AddRow();
	        if(ds_cust.CountRow==0){
	            alert("������ ������ ���� ��ȸ �� Ŭ���Ͻñ� �ٶ��ϴ�.");
	            return;
	        } else {
	            ds_cust.DeleteRow(ds_cust.CountRow);
	        }
	    }
	    fnTourCust('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');
    }

</script>

<%
/*=============================================================================
            DataSet Components(DS) ����
=============================================================================*/
%>

<!-- �⺻���� -->
<object id=ds_search classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- ��Ÿ�� ���ʵ����� ���� -->
<object id=ds_room classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<!-- ��� ���� -->
<object id=ds_block classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- ������ ��� -->
<object id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- ������ ��� -->
<object id=ds_tour classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- ���� ��� -->
<object id=ds_car classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<!-- ForeCasting ��� -->
<object id=ds_forecasting classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- ���� ���� ���ʵ����� ���� -->
<object id=init_businessDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- ����Ÿ�� ���ʵ����� ���� -->
<object id=init_blockTypeDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- �� ���ɴ� ���ʵ����� ���� -->
<object id=init_ageDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- �� �������� ���ʵ����� ���� -->
<object id=init_custTypeDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- ������ ���ʵ����� ���� -->
<object id=init_custGuDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- ������� ���ʵ����� ���� -->
<object id=init_saupGuDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- �� ���� ���ʵ����� ���� -->
<object id=init_joinDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- ���ͽð� ���ʵ����� ���� -->
<object id=init_arrTimeDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<%//<!-- ���ܱ��б��ʵ����� ���� -->%>
<object id=init_boundDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- ������ �߰��� ���� �ӽ� DataSet -->
<object id=ds_cust_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- ������ ���� ���� ��� -->
<object id=ds_cust_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- �� ���� ���� ���� ��� -->
<object id=ds_room_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- �ǸŰ� ��� ���� ��� -->
<object id=ds_amt_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- ������ �߰��� ���� �ӽ� DataSet -->
<object id=ds_save_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- ���λ󼼸� ���� �����ͼ� �߰� 2007-05-11 by �ɵ��� ------------------------------------------------->
<!-- �������� ���ʵ����� ���� -->
<object id=init_carownerDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- ���ֿ��� ���ʵ����� ���� -->
<object id=init_jejuDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- �ָ����� ���ʵ����� ���� -->
<object id=init_weekendDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<!-- �� �׸��ڵ� ���ʵ����� ���� -->
<object id=init_themeDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=init_payPreDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=init_paySaupDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr_search" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr_cust" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr_temp" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%//<!-- ������ ����� ���õ� Components -->%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=imgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=initds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <PARAM NAME="SyncLoad" VALUE="False">
</object>
<object id=initds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <PARAM NAME="SyncLoad" VALUE="False">
</object>



</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		




<table width="1000" border="0" cellspacing="0" cellpadding="0" valign=top>
    <tr>
        <td valign=top>
            <table width="554" border="0" cellspacing="0" cellpadding="0" valign=top >
                <tr>
                    <td width="554" colspan="3" valign=top>
                        <table width="554" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr>
                                <td width="52" height="25" class="text">���¾�ü</td>
                                <td width="90" bgcolor="#FFFFFF">&nbsp;<input type="text" value="<%=c_nm%>" name='v_client_nm' id='v_client_nm' style="width:55px;" class='input01' readOnly>
                                    <input type="hidden" name='v_client_sid' value="<%=c_sid%>" id='v_client_sid'><%if(v_ut.equals("")){%><img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" id="v_client_btn" onclick="fnSelClientPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>');">
                                    <%}%></td>
                                <td width="72" height="25" class="text">��û����ȣ</td>
                                <td width="131" bgcolor="#FFFFFF">&nbsp;
                                    <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='95px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="00000-000000000">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=true>
                                    <%if(!v_ut.equals("")){%>
                                        <param name=Text        value="<%=c_cd%>">
                                    <%}%>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    <input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onClick="fnAcceptNoPopup('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')" id="v_accept_btn"></td>
                                <td width="62" height="25" class="text" >��ü���</td>
                                <td width="142" bgcolor="#FFFFFF">&nbsp;<input name="v_event_no" id="v_event_no" type="text" style="width:30px;" class="input01" readOnly>
                                    <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer;display:" id="v_event_btn" onclick="fnGroupPopup('<%=dirPath%>');">
                                    <input type=hidden name="v_event_sid" id="v_event_sid"><input name="v_event_nm" type="text" style="width:60px;" class="input01" readOnly></td>
                            </tr>
                        </table>
                        
                        <table height=6px><tr><td></td></tr></table>

                        <table width="554" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr>
                                <td width="52" height="25" class="text">Bound</td>
                                <td width="90" bgcolor="#FFFFFF">&nbsp;
                                    <object id=v_bound classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
                                        <param name=ComboDataID         value=init_boundDs>
                                        <param name=EditExprFormat  	value="%,%,%;head,detail,detail_nm">
                                        <param name=ListExprFormat 		value="detail_nm^0^70">
                                        <param name=BindColumn          value="detail">
                                    </object>
                                    </td>                                
                                <td width="72" height="25" class="text" >����</td>
                                <td width="131" bgcolor="#FFFFFF">&nbsp;
                                    <object id=v_business classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=90 border="0" align=absmiddle>
                                        <param name=ComboDataID         value=init_businessDs>
                                        <param name=SearchColumn        value="saup_nm">
                                        <param name=Sort                value="false">
                                        <param name=ListExprFormat      value="saup_nm^0^90">
                                        <param name=BindColumn          value="saup_sid">
                                    </object>
                                    
                                </td>
                                <td width="62" height="25" class="text">��ǰ����</td>
                                <td width="142" bgcolor="#FFFFFF"><b>&nbsp;<font onclick="fnSeqPrev()">��</font>&nbsp;
                                    <object id=v_bound_seq classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='20px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="0">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    &nbsp;/&nbsp;
                                    <object id=v_bound_total_seq classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='20px' align='absmiddle' class='textbox'>
                                        <param name=Format      value="0">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=false>
                                    </object>
                                    &nbsp;<font onclick="fnSeqNext()">��</font></b></td>
                            </tr>
                            <tr height="25">
                                <td class="text" >�������</td>
                                <td colspan="2" bgcolor="#FFFFFF">&nbsp;
                                    <object id=v_depart_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    
                                    &nbsp;
                                    <object id=v_depart_time classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='35px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="##:##">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    
                                    &nbsp;<input name="v_nights" id="v_nights" type="text" style="width:20px;" class="input01" readOnly></td>
                                <td colspan="3" bgcolor="#FFFFFF">&nbsp;
                                    <object id=v_goods_nm classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=130 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_search>
                                        <param name=EditExprFormat  value="%;goods_nm">
                                        <param name=ListExprFormat  value="goods_nm^0^200">
                                    </object>
                                    
                                    &nbsp;
                                    <object id=v_blockType classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=init_blockTypeDs>
                                        <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                        <param name=ListExprFormat  value="detail_nm^0^80">
                                    </object>
                                    
                                    &nbsp;
                                    <object id=v_roomType classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=90 border="0" align=absmiddle>
                                        <param name=ComboDataID     value=ds_room>
                                        <param name=SyncComboData   value=true>
                                        <param name=EditExprFormat  value="%,%,%;ROOM_TYPE_SID,ROOM_TYPE_CD,ROOM_TYPE_NM">
                                        <param name=ListExprFormat  value="ROOM_TYPE_CD^0^140">
                                    </object>
                                    
                                </td>
                            </tr>
                            <tr height="25">
                                <td class="text" >��������</td>
                                <td bgcolor="#FFFFFF" colspan="2">&nbsp;
                                    <object id=v_arrive_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="YYYY-MM-DD">
                                        <PARAM NAME=InputFormat value="YYYYMMDD">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=false>
                                        <param name=MaxLength   value="8">
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    
                                    &nbsp;
                                    <object id=v_arrive_time classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='35px' align='absmiddle' class='textbox'>            
                                        <param name=Format      value="##:##">
                                        <param name=Alignment   value=1>
                                        <param name=ClipMode    value=true>
                                        <param name=Border      value=false>
                                        <param name=Enable      value=false>
                                        <param name=SelectAll   value=true>
                                        <param name=SelectAllOnClick      value=true>
                                        <param name=SelectAllOnClickAny   value=false>
                                    </object>
                                    
                                </td>
                                <td colspan="3" bgcolor="#FFFFFF" align=right><!--<img src="<%=dirPath%>/Sales/images/reset.gif" align="absmiddle" style="cursor:pointer" onClick="fnReset()"> -->
                                	&nbsp;<img src="<%=dirPath%>/Sales/images/resetAll.gif" align="absmiddle" style="cursor:pointer" onClick="fnResetAll()">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr>
                    <td><%// ����κ�: ���ǻ��� + ������ %>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="114" valign=top><%//���ǻ��±׸���%>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td height="28"><img src="<%=dirPath%>/Sales/images/trace_dot.gif" width="4" height="4" align="absmiddle">&nbsp;<strong>���ǻ��� </strong><span id="block_title"></span></td>
                                        </tr>
                                        <tr>
                                            <td valign=top>
                                                <%// ���ǻ���: ds_block %>
                                                <object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_block  style="width=114px; height:209px" border="1">
                                                    <param name="DataID"        VALUE="ds_block">
                                                    <param name="BorderStyle"   VALUE="0">
                                                    <param name=ColSizing       value="true">
                                                    <param name="editable"      value="false">
                                                    <param name="ViewSummary"   value="1">
                                                    <param name="Format"        VALUE="
                                                        <!-- C> name=''       ID='{CURROW}'  Width=20   align=Center</C-->
                                                        <G> name='�ο�'
                                                        <C> name='R'    ID='RSV_PERSONS'     Width=34      align=Center Edit=none sumtext=@cnt</C>
                                                        <C> name='S'    ID='STD_PERSONS'     Width=32     align=Center Edit=none sumtext=��</C>
                                                        <C> name='M'    ID='MAX_PERSONS'     Width=32     align=Center Edit=none</C>
                                                        </G>
                                                    ">
                                                </object>
                                                
                                            </td>
                                        </tr>
                                    </table>
                                </td>
								<td width="6">&nbsp;</td>
                                <td valign=top><%//���������� ����%>
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                        	<td colspan=3>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr  height="28">
	                                                    <td align="left"><img src="<%=dirPath%>/Sales/images/trace_dot.gif" width="4" height="4" align="absmiddle">&nbsp;<strong>�ֹ�/����</strong>&nbsp;
                                                            <object id=v_manage_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height='16px' width='85px' align='absmiddle' class='textbox'>
                                                                <param name=Format      value="#############">
                                                                <param name=Alignment   value=1>
                                                                <param name=ClipMode    value=true>
                                                                <param name=Border      value=false>
                                                                <param name=SelectAll   value=true>
                                                                <param name=SelectAllOnClick      value=true>
                                                                <param name=SelectAllOnClickAny   value=false>
                                                            </object>
                                                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer;display:" id="v_btn_pop" onclick="fnCustPopup('<%=dirPath%>','');">
                                                        </td>
                                                        <td align=right>
                                                            <img src="<%=dirPath%>/Sales/images/add.gif"    id="btn_cust_add"  style="display:none;cursor:pointer" onClick="fnCustAdd('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
                                                            <img src="<%=dirPath%>/Sales/images/delete.gif" id="btn_cust_del"  style="display:none;cursor:pointer" onClick="fnCustDel('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
                                                            <img src="<%=dirPath%>/Sales/images/save.gif"   id="btn_cust_save" style="display:none;cursor:pointer" onClick="fnCustSave('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
                                                            <img src="<%=dirPath%>/Sales/images/cancel.gif" id="btn_cust_cancel" style="display:none;cursor:pointer" onClick="fnCustCancel()">
                                                        </td>
                                                    </tr>
                                                </table>
                                        	</td>
                                        </tr>
                                        <tr>
                                            <td width="102" height="120" valign=top>
                                                <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                                                    <tr bgcolor="#ffffff">    
                                                        <td width="100%" height="120">
                                                            <img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" border=0 width="100" height="120">
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                                                    <tr bgcolor="#ffffff" height=20>    
                                                        <td align=center bgcolor="#efefef" width=40><b>����</b></td>
                                                        <td align=center>
														
							                            <object id=lc_carowner classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=42 width=60 border="0" align=absmiddle>
															<param name=ComboDataID		value=init_carownerDs>
															<param name=BindColumn      value="detail">
                                                			<param name=BindColVal      value="detail">
															<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
															<param name=ListExprFormat  value="detail_nm^0^60">
														</object>
															</td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff" height=20>
                                                        <td align=center bgcolor="#efefef"><b>�Ļ�</b></td>
                                                        <td align=center>
                                                        
							                            <object id=lc_theme classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=63 width=60 border="0" align=absmiddle>
															<param name=ComboDataID		value=init_themeDs>
															<param name=BindColumn      value="detail">
                                                			<param name=BindColVal      value="detail">
															<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
															<param name=ListExprFormat  value="detail_nm^0^60">
														</object>
															</td>
                                                    </tr>

                                                    <tr bgcolor="#ffffff" height=20>
                                                     	<td align=center bgcolor="#efefef">����</td>
                                                        <td align=center>
                                                        
							                            <object id=lc_jeju classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=42 width=60 border="0" align=absmiddle>
															<param name=ComboDataID		value=init_jejuDs>
															<param name=BindColumn      value="detail">
                                                			<param name=BindColVal      value="detail">
															<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
															<param name=ListExprFormat  value="detail_nm^0^60">
															<param name=Enable2  value=false>
														</object>
															</td>
													</tr>
                                                    <tr bgcolor="#ffffff" height=20>
                                                     	<td align=center bgcolor="#efefef">�ָ�</td>

                                                        <td align=center>
                                                        
							                            <object id=lc_weekend classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=42 width=60 border="0" align=absmiddle>
															<param name=ComboDataID		value=init_weekendDs>
															<param name=BindColumn      value="detail">
                                                			<param name=BindColVal      value="detail">
															<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
															<param name=ListExprFormat  value="detail_nm^0^60">
															<param name=Enable2  value=false>
														</object>
															</td>
                                                    </tr>
                                                </table>                                                            
                                            </td>
                                            <td width="3">&nbsp;</td>
                                            <td width="326" valign="top">
                                                <table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                                                    <tr height="25">
                                                        <td class="text" width=70>����</td>
                                                        <td width=92 bgcolor="#FFFFFF">&nbsp;<input type=text name="cust_company_nm" id="cust_company_nm" class="input01" size=12 readOnly></td>
                                                        <td class="text" width=70>����</td>
                                                        <td width=92 bgcolor="#FFFFFF">&nbsp;<input name="cust_positions" id="cust_positions" type="text" class="input01" size="12" readOnly></td>
                                                    </tr>
                                                    <tr height="25">
                                                        <td class="text">�������</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_birthday" id="cust_birthday" type="text" class="input01" size=12 readOnly></td>
                                                        <td class="text">����</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_sex" id="cust_sex" type="text" class="input01" size=12 readOnly></td>
                                                    </tr>
                                                    <tr height="25">
                                                        <td class="text">����/����</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_country_nm" id="cust_country_nm" type="text" class="input01" size=12 OnKeyUp="cfLengthCheck(this, 15);" readOnly></td>
                                                        <td class="text">�޴���</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_mobile_no" id="cust_mobile_no" type="text" class="textbox" size=12 OnKeyUp="cfLengthCheck(this, 15);" readOnly></td>
                                                    </tr>
                                                    <tr height="25">
                                                        <td class="text">����ñ�</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;
								                            <object id=lc_payPre classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=42 width=60 border="0" align=absmiddle>
																<param name=ComboDataID		value=init_payPreDs>
																<param name=BindColumn      value="detail">
	                                                			<param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
																<param name=ListExprFormat  value="detail_nm^0^60">
															</object>
																</td>
                                                        <td class="text">������</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;
								                            <object id=lc_paySaup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=42 width=60 border="0" align=absmiddle>
																<param name=ComboDataID		value=init_paySaupDs>
																<param name=BindColumn      value="detail">
	                                                			<param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
																<param name=ListExprFormat  value="detail_nm^0^60">
															</object>
																</td>
                                                    </tr>
                                                    <tr height="25">
                                                        <td class="text">�ǹ���ȣ</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_work_no" id="cust_work_no" type="text" class="input01" size="12" readOnly></td>
                                                        <td class="text">�������ȣ</td>
                                                        <td bgcolor="#FFFFFF">&nbsp;<input name="cust_unity_no" id="cust_unity_no" type="text" class="input01" size=12 readOnly></td>
                                                    </tr>
                                                    <tr height="25">
                                                        <td class="text">��ϸ���</td>
                                                        <td colspan=3 bgcolor="#FFFFFF">&nbsp;<input name="cust_north_purpose" id="cust_north_purpose" type="text" class="textbox" size="38" onClick="this.select();" readOnly></td>
                                                    </tr>
                                                    <tr height="53">
                                                        <td class="text">�������</td>
                                                        <td colspan="3" bgcolor="#FFFFFF">&nbsp;<textarea name="cust_remarks" id="cust_remarks"  class=textbox cols=38 rows=3 OnKeyUp="cfLengthCheck(this, 100);" onClick="this.select();" readOnly></textarea></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>

                                </td><%//���������� ��%>
                            </tr>
                        </table>
                    </td><%// ����κ�: ���ǻ��� + ������ ��%>
                </tr>
                <tr>
                    <td height="20"><img src="<%=dirPath%>/Sales/images/trace_dot.gif" width="4" height="4" align="absmiddle">&nbsp;<strong>������ ���</strong>&nbsp;&nbsp;(�������� ����� �� Ŭ��)</td>
                </tr>
                <tr>
                    <td><%//�ϴܺ� ������ GRID ����%>
                        
                        <object classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr_cust  style="width=554px; height:200px" border="1">
                            <param name="DataID"        VALUE="ds_cust">
                            <param name="BorderStyle"   VALUE="0">
                            <param name=ColSizing       value="true">
                            <param name="editable"      value="true">
                            <param name="Format"        VALUE="
                                <C> name='No'           ID='{CURROW}'       Width=25    align=Center Edit=None</C>
                                <C> name='��'           ID='DUMMY_COL' 		Width=20    align=Center EditStyle=popup </C>
								<C> name='��������'   	ID='ARRIVE_DATE'    Width=68	align=center Edit=None editlimit=8 suppress=1 mask='XXXX-XX-XX'</C>
								<C> name='����(����)'   	ID='ARRIVE_TIME'    Width=75	align=center EditStyle=Lookup Data='init_arrTimeDs:detail:detail_nm' </C>
                                <C> name='�ֹ�/����'	ID='MANAGE_NO'      Width=85	align=Left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                <C> name='����'			ID='CUST_NM'        Width=50    align=Left Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                <C> name='����'			ID='AGE_CD'         Width=40    align=Left EditStyle=Lookup Data='init_ageDs:DETAIL:DETAIL_NM'</C>
                            <%
                                if(v_ut.equals("")){
                            %>
                                <C> name='������'    ID='CUST_TYPE'      Width=60    align=Left EditStyle=Lookup Data='init_custTypeDs:DETAIL:DETAIL_NM'</C>
                            <%
                                } else {
                            %>
                                <C> name='������'    ID='CUST_TYPE_NM'      Width=60    align=Left Edit=None</C>
                            <%
                                }
                            %>
                                
                                <C> name='���'       ID='SAUP_GU'     Width=55  align=Left EditStyle=Lookup Data='init_saupGuDs:DETAIL:DETAIL_NM'</C>
                                <C> name='����'       ID='JOIN_CD'     Width=45  align=Left EditStyle=Lookup Data='init_joinDs:DETAIL:DETAIL_NM'</C>
                                <C> name='����'       ID='CAROWNER_YN' Width=50  align=Left Edit=None SHOW=FALSE</C>
                                <C> name='����'       ID='JEJU_YN'     Width=50  align=Left Edit=None SHOW=FALSE</C>
                                <C> name='�ָ�'       ID='WEEKEND_YN'  Width=50  align=Left Edit=None SHOW=FALSE</C>
                                <C> name='�׸�'       ID='THEME_CD'    Width=50  align=Left Edit=None SHOW=FALSE</C>
                                
                                <C> name='�ǹ���ȣ'       ID='WORK_NO'    Width=50  align=Left Edit=None SHOW=FALSE</C>
                                <C> name='��ϸ���'       ID='NORTH_PURPOSE'    Width=50  align=Left Edit=None editlimit=30 SHOW=true</C>
                                <C> name='�������'       ID='REMARKS'    Width=50  align=Left Edit=None editlimit=200 SHOW=true</C>
                                <C> name='�������ȣ'     ID='UNITY_NO'    Width=50  align=Left Edit=None SHOW=FALSE</C>
                                <C> name='����ñ�'       ID='PAY_PRE'    Width=50  align=Left Edit=None SHOW=FALSE</C>
                                <C> name='������'       ID='PAY_SAUP'    Width=50  align=Left Edit=None SHOW=FALSE</C>
                            ">
                        </object>
                        
                    
                    </td><%//�ϴܺ� ������ GRID ��%>
                </tr>
                
            </table>
        </td>
        <td width="6">&nbsp;</td>
        <td width="450" height="524" valign=top>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table height="30" border="0" cellspacing="0" cellpadding="0" align=left>
                            <tr>                                
                                <td width="95"><img src="<%=dirPath%>/Sales/images/tab_05.gif" name="sub1" width="95" height="28" border="0" onMouseOver="changesub(1)" onMouseOut="changesubout(1)" style="cursor:pointer" onClick="changesubclick(1), fnOnChangTab('1')"></td>
                                <td width="95"><img src="<%=dirPath%>/Sales/images/tab_04.gif" name="sub2" width="95" height="28" border="0" onMouseOver="changesub(2)" onMouseOut="changesubout(2)" style="cursor:pointer" onClick="changesubclick(2), fnOnChangTab('2')"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="497" valign=top style="padding-top:4px">
                        <!-- ������ ��� TAB -->
                        <table id=tb_tourlist style="display:inline" border=0 cellspacing=0 cellpadding=0>
							<tr  height="26">                              
                                <td align=left valign=middle>����� �ڷ���ȸ<input type=checkbox name=v_accept_check id=v_accept_check>
                                    &nbsp;<img src="<%=dirPath%>/Sales/images/refresh.gif" style="cursor:pointer" id=v_tour_check style="display:none" onClick="fnGetTour('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')"></td>
                            </tr>
                            <tr>
                                <td valign=top>
                                    
                                    <object classid=<%=HDConstant.CT_GRID_CLSID%> id=gr_tourlist  style="width:448px; height:510px" border="1">
                                        <param name="DataID"        VALUE="ds_tour">
                                        <param name="BorderStyle"   VALUE="0">
                                        <param name=ColSizing       value="true">
                                        <param name="editable"      value="true">
                                        <Param Name="SuppressOption"      value="1">
                                        <param name=ViewSummary     value=1>
                                        <Param Name="SortView"     value="Right">
                                        <param name="Format"         VALUE="
                                            <C> name='��ǰ'		   ID='GOODS_NM'  Width=70   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left suppress=1 sort=false SumText='��'  SumTextAlign=right</C>
                                            <C> name='����\\���'   ID='ROOM_TYPE_CD'  Width=50   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left suppress=1 sort=true SumText=@cnt SumTextAlign=right</C>
                                            <C> name='����'        ID='CUST_NM'       Width=140   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left sort=true SumText='��' SumTextAlign=left </C>
                                            <C> name='�ǸŰ�'       ID='TOUR_AMT'     Width=65   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Right dec=0 show=False</C>
                                            <C> name='����\\����'   ID='CUST_TYPE_NM'  Width=80   Edit=None  bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left sort=true</C>
                                            <C> name='�ֹε�Ϲ�ȣ'  ID='MANAGE_NO_s'     Width=80   Edit=None  bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Left</C>
                                            <C> name='�ɼ�\\���'    ID='OPTION_AMT'  Width=65   Edit=None   bgcolor={DECODE(MOVE_TEMP,'M','<%=HDConstant.GRID_ITEM%>',DECODE(JOIN_CD, '01', '<%=HDConstant.GRID_TOUR_COLOR%>', ''))} align=Right SumText=@sum SumTextAlign=right dec=0 show=False</C>
                                        ">
                                    </object>
                                    
                                </td>
                            </tr>
                        </table>

                        <!-- ���� ��� TAB -->
                        <table id=tb_car style="display:none" border=0 cellspacing=0 cellpadding=0>
                            <tr>                                
                                <td align=right valign=middle>
             
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								    <tr  height="26">
								        <td align=right>
								            <img src="<%=dirPath%>/Sales/images/add.gif"    id="btn_cust_add"  style="cursor:pointer" onClick="fnCarAdd('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
								            <img src="<%=dirPath%>/Sales/images/delete.gif" id="btn_cust_del"  style="cursor:pointer" onClick="fnCarDel('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
								            <img src="<%=dirPath%>/Sales/images/save.gif"   id="btn_cust_save" style="cursor:pointer" onClick="fnCarSave('<%=dirPath%>', '<%=HDConstant.PATH_RV%>')">
								            <img src="<%=dirPath%>/Sales/images/cancel.gif" id="btn_cust_cancel" style="cursor:pointer" onClick="fnCarCancel()">
								        </td>
								    </tr>
								</table>
                                
                                
								</td>
                            </tr>
                            <tr>
                                <td valign=top>
                                    
                                    <object classid=<%=HDConstant.CT_GRID_CLSID%> id=gr_carlist  style="width:448px; height:510" border="1">
                                        <param name="DataID"        VALUE="ds_car">
                                        <param name="BorderStyle"   VALUE="0">
                                        <param name=ColSizing       value="true">
                                        <param name="editable"      value="true">
                                        <Param Name="SuppressOption"      value="1">
                                        <param name=ViewSummary     value=1>
                                        <Param Name="SortView"     value="Right">
                                        <param name="Format"         VALUE="
											<C> name='��������'		ID='ARRIVE_DATE'  Width=68  editlimit=8	align=Left sort=false mask='XXXX-XX-XX'  SumText='��'  SumTextAlign=right</C>
											<C> name='�԰�ð�\\(��/��)' 	ID='ARRIVE_TIME'  Width=75	editlimit=4 align=Left EditStyle=Lookup Data='init_arrTimeDs:detail:detail_nm'  SumText=@cnt SumTextAlign=right</C>
								                <C> name='����SID'      ID='car_sid'    align=left width=100 	editlimit=12 	show=false</C>
											<C> name='����'       	ID='car_nm'      	align=left width=80 	editlimit=32 	show=true  	editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%>  SumText='��' SumTextAlign=left</C>
											<C> name='����\\��Ϲ�ȣ'	ID='CAR_NO'	  	align=center Width=60    Edit=None 	sort=false</C>
											<C> name='����' 		ID='CAR_TYPE' 	  	align=left Width=65   	Edit=None</C>
											<C> name='�������' 		ID='car_desc'       align=left width=80 	editlimit=100 	show=true  bgColor=<%=HDConstant.GRID_ITEM%></C>
												<C> name='��ûSID'   	ID='accept_sid'  	align=left width=100 	editlimit=12 	show=false </C>
												<C> name='��ǰ����'   	ID='bound_seq'  	align=left width=60 	editlimit=12 	show=false </C>
												<C> name='�븮��SID'   	ID='client_sid'  	align=left width=100 	editlimit=12 	show=false </C>
												<C> name='�������'		ID='depart_DATE'  Width=70  Edit=None	align=Left sort=false mask='XXXX-XX-XX' show=false</C>
												<C> name='�ð�'   		ID='depart_TIME'  Width=50	Edit=None	align=Left sort=false show=false</C>
												<C> name='��������SID'  	ID='car_rsv_sid'    align=left width=100 	editlimit=12 	show=false </C>
												<C> name='ȭ��'        	ID='cargo'       	align=left width=80 	editlimit=100 	show=false</C>
                                        ">
                                    </object>
                                    
                                </td>
                            </tr>
                        </table>
                        
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

     <object id=searchBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds_search">
             <param name=BindInfo    value="
                <C>Col=DEPART_DATE     Ctrl=v_depart_date          Param=Text</C>
                <C>Col=DEPART_TIME     Ctrl=v_depart_time          Param=Text</C>
                <C>Col=ARRIVE_DATE     Ctrl=v_arrive_date          Param=Text</C>
                <C>Col=ARRIVE_TIME     Ctrl=v_arrive_time          Param=Text</C>
                <C>Col=NIGHTS          Ctrl=v_nights               Param=Value</C>

                <C>Col=BOUND_SEQ       Ctrl=v_bound_seq				Param=Text</C>
                <C>Col=BOUND_TOTAL     Ctrl=v_bound_total_seq		Param=Text</C>
                                
                
              ">
     </object>
     <object id=custBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds_cust">
             <param name=BindInfo    value="
                <C>Col=CUST_ENM        Ctrl=cust_cust_enm               Param=Value</C>
                <C>Col=BIRTHDAY        Ctrl=cust_birthday               Param=Value</C>
                <C>Col=COMPANY_NM      Ctrl=cust_company_nm             Param=Value</C>
                <C>Col=POSITIONS       Ctrl=cust_positions              Param=Value</C>
                <C>Col=ADDRESS1        Ctrl=cust_address1               Param=Value</C>
                <C>Col=COUNTRY_NM      Ctrl=cust_country_nm             Param=Value</C>
                <C>Col=PASS_TYPE       Ctrl=cust_pass_type              Param=Value</C>
                <C>Col=PASS_NO         Ctrl=cust_pass_no                Param=Value</C>
                <C>Col=NORTH_CNT       Ctrl=cust_north_cnt              Param=Value</C>

                <C>Col=SEX             Ctrl=cust_sex                    Param=Value</C>
                <C>Col=MOBILE_NO       Ctrl=cust_mobile_no              Param=Value</C>
                <C>Col=REMARKS         Ctrl=cust_remarks                Param=Value</C>

                <C>Col=WORK_NO			Ctrl=cust_work_no     			Param=Value</C>
                <C>Col=NORTH_PURPOSE    Ctrl=cust_north_purpose     	Param=Value</C>
                <C>Col=UNITY_NO      	Ctrl=cust_unity_no     			Param=Value</C>
                <C>Col=PAY_PRE 	    	Ctrl=lc_payPre   	 	Param=BindColVal</C>
                <C>Col=PAY_SAUP     	Ctrl=lc_paySaup   	 	Param=BindColVal</C>
                                                
                <C>Col=CAROWNER_YN     Ctrl=lc_carowner   	 	Param=BindColVal</C>
                <C>Col=JEJU_YN         Ctrl=lc_jeju   	 		Param=BindColVal</C>
                <C>Col=WEEKEND_YN      Ctrl=lc_weekend   	 	Param=BindColVal</C>
                <C>Col=THEME_CD        Ctrl=lc_theme   	 		Param=BindColVal</C>
              ">
     </object>
     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds1">
             <param name=BindInfo    value="
                <C>Col=group_cd         Ctrl=group_cd           Param=Text</C>
                <C>Col=height           Ctrl=height             Param=Text</C>
                <C>Col=regi_no          Ctrl=regi_no            Param=Text</C>
                <C>Col=regi_yn          Ctrl=lc_regi_yn         Param=BindColVal </C>
                <C>Col=cust_gu          Ctrl=lc_cust_gu         Param=BindColVal</C>
                <C>Col=country_gu       Ctrl=lc_country_gu      Param=value</C>
                <C>Col=saup_gu          Ctrl=lc_saup_gu         Param=BindColVal</C>
                <C>Col=cust_type        Ctrl=lc_cust_type       Param=BindColVal </C>
                <C>Col=CUST_NM          Ctrl=txt_cust_nm        Param=Value</C>
                <C>Col=last_nm          Ctrl=last_nm            Param=Text</C>
                <C>Col=country_cd       Ctrl=country_cd         Param=Value</C>
                <C>Col=nation_cd        Ctrl=lc_nation          Param=Value </C>
                <C>Col=birthday         Ctrl=birthday            Param=Text</C>
                <C>Col=sex              Ctrl=lc_sex             Param=BindColVal</C>
                <C>Col=tel_no           Ctrl=tel_no             Param=value</C>
                <C>Col=mobile_no        Ctrl=mobile_no          Param=value</C>
                <C>Col=zip_cd           Ctrl=zip_cd             Param=Text</C>
                <C>Col=address1         Ctrl=txt_address1       Param=value</C>
                <C>Col=address2         Ctrl=txt_address2       Param=value</C>
                <C>Col=eng_zip_cd       Ctrl=eng_zip_cd         Param=Text</C>
                <C>Col=eng_addr1        Ctrl=txt_eng_addr1      Param=value</C>
                <C>Col=pass_type        Ctrl=lc_pass_type       Param=BindColVal</C>
                <C>Col=pass_no          Ctrl=pass_no            Param=Text</C>
                <C>Col=pass_expire_date Ctrl=pass_expire_date   Param=Text</C>
                <C>Col=company_nm       Ctrl=txt_company_nm         Param=Value</C>
                <C>Col=positions        Ctrl=txt_positions          Param=Value</C>
                <C>Col=eng_company_nm   Ctrl=eng_company_nm     Param=Text</C>
                <C>Col=eng_position     Ctrl=eng_position       Param=Text</C>
                <C>Col=north_cnt        Ctrl=north_cnt          Param=value </C>
                <C>Col=client_sid       Ctrl=client_sid       Param=Value</C>
                <C>Col=client_nm        Ctrl=client_nm          Param=Value</C>
              ">
      </object>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

