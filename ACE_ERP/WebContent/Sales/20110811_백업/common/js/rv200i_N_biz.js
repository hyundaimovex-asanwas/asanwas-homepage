    var v_cust_flag = "";
    var v_room_flag = "";
    var v_block_row = 0;
    var v_cust_row = 0;
    /**
     * Tab Image Control
     */
    function fnOnChangTab(tab_idx){
//    	alert(tab_idx);
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
        if(s_accept_no != getObjectFirst("v_accept_no").Text.trim() && getObjectFirst("v_accept_no").Text.trim()!="")
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
        if(s_accept_no != getObjectFirst("v_accept_no").Text.trim() && getObjectFirst("v_accept_no").Text.trim()!="")
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
        if(s_depart_date != getObjectFirst("v_depart_date").Text.trim()
            && getObjectFirst("v_depart_date").Text.trim()!="" 
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
			
            if(getObjectFirst("ds_search").NameValue(row, "DEPART_DATE")==""){
                getObjectFirst("v_depart_date").Enable = "True";
            }
            
            getObjectFirst("v_tour_check").style.display = "inline";
	    } else if(v_function == "DEPART"){
	        s_accept_no = "";
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
        if(v_blockType.Index==0) return;
        
        if(getObjectFirst("v_client_nm").value==""){
            alert("���¾�ü�� ���� �����Ͻñ� �ٶ��ϴ�.");
            v_blockType.Index = 0;
            return;
        }
        if(v_blockType.ValueOfIndex("DETAIL", v_blockType.Index)!=""){
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
        if(v_blockType.ValueOfIndex("DETAIL", v_blockType.Index)!=""
            && v_roomType.ValueOfIndex("ROOM_TYPE_SID", v_roomType.Index)!="0"
            && getObjectFirst("v_client_sid").value!=""){
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
            
            if(v_ut==""){
                getObjectFirst("v_client_btn").style.display        = "none";
            }
//            getObjectFirst("v_event_btn").style.display         = "none";
            getObjectFirst("btn_cust_add").style.display        = "none";
            getObjectFirst("btn_cust_del").style.display        = "none";
            getObjectFirst("btn_cust_save").style.display       = "none";
            getObjectFirst("btn_cust_cancel").style.display       = "none";
//            getObjectFirst("btn_amtSave").style.display         = "inline";
            
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
            
            if(v_ut==""){
                getObjectFirst("v_client_btn").style.display        = "inline";
            }
//            getObjectFirst("v_event_btn").style.display         = "none";
            getObjectFirst("btn_cust_add").style.display        = "none";
            getObjectFirst("btn_cust_del").style.display        = "none";
            getObjectFirst("btn_cust_save").style.display       = "none";
            getObjectFirst("btn_cust_cancel").style.display       = "none";
//            getObjectFirst("btn_amtSave").style.display         = "none";
            
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
            
            if(v_ut == ""){
                getObjectFirst("v_client_btn").style.display        = "inline";
            }
//            getObjectFirst("v_event_btn").style.display         = "none";
            getObjectFirst("btn_cust_add").style.display        = "none";
            getObjectFirst("btn_cust_del").style.display        = "none";
            getObjectFirst("btn_cust_save").style.display       = "none";
            getObjectFirst("btn_cust_cancel").style.display       = "none";
//            getObjectFirst("btn_amtSave").style.display         = "none";
            
            getObjectFirst("v_tour_check").style.display        = "none";
            
//            getObjectFirst("v_fr_date").Text = "";
//            getObjectFirst("v_to_date").Text = "";
            getObjectFirst("v_manage_no").Text = "";
            getObjectFirst("v_accept_sid").value = "";
            
            if(v_ut==""){
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
//            getObjectFirst("btn_amtSave").style.display         = "none";
            
            fnCustClear();
        } else if(v_function == "ROOM"){
            getObjectFirst("ds_block").ClearAll();
            getObjectFirst("ds_cust").ClearAll();

            getObjectFirst("btn_cust_add").style.display        = "none";
            getObjectFirst("btn_cust_del").style.display        = "none";
            getObjectFirst("btn_cust_save").style.display       = "none";
            getObjectFirst("btn_cust_cancel").style.display       = "none";
//            getObjectFirst("btn_amtSave").style.display         = "inline";
            
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
//            if(v_ut=="")
//            	getObjectFirst("hold_btn").style.display = "inline";
        } else {
            getObjectFirst("cust_mobile_no").readOnly = true;
            getObjectFirst("cust_remarks").readOnly = true;
            getObjectFirst("cust_north_purpose").readOnly = true;
//            if(v_ut=="")
//            	getObjectFirst("hold_btn").style.display = "none";
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
//        lc_country_gu.Index = 0;

        fnCustDisplay("");
        
//        getObjectFirst("regi_no").Text          = "";
//        getObjectFirst("pass_no").Text          = "";
//        getObjectFirst("pass_expire_date").Text = "";
//        getObjectFirst("birthday").Text         = "";
     
//        getObjectFirst("zip_cd").Text           = "";
//        getObjectFirst("eng_company_nm").Text   = "";
//        getObjectFirst("eng_position").Text     = "";
//        getObjectFirst("txt_company_nm").value  = "";
//        getObjectFirst("txt_positions").value   = "";
//        getObjectFirst("txt_cust_nm").value     = "";
//        getObjectFirst("txt_address1").value    = "";
//        getObjectFirst("txt_address2").value    = "";
//        getObjectFirst("txt_eng_addr1").value   = "";
//        getObjectFirst("country_cd").value      = "";
//        getObjectFirst("lc_nation").value       = "";
        
    }
    
    /**
     * �� ���� ��ȸ
     */
    function fnCustInfoFind(dirPath, servletPath){
//        var v_country_gu = lc_country_gu.ValueOfIndex("DETAIL", lc_country_gu.Index)
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
alert(v_param);
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
//            getObjectFirst("lc_country_gu").Enable   = "False";
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
//    	alert("prev");
    	//1. ������
    	//2. �ű� �� ����.
    }
    




    
// �������� �߰�  20100212 �ɵ���********************************************************
	function fnCarAdd(){
		if(!getObjectFirst("v_accept_sid").value){
			alert("��û����ȣ�� �����ϴ�.\n\n��û����ȣ �Է�|�˻� ��\n������ �߰��Ͻ� �� �ֽ��ϴ�.");
			return;
		}
		if(v_bound_seq.text == "" || v_bound_seq.text=="0"){ //Ȥ�ó� üũ
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
	
	
	
	
	
	
	