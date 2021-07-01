<!--
***********************************************************************
* @source      : .jsp
* @description : 월간근태현황통계 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/11/05      권혁수        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
/*   EZGEN 파일에서 받는 parameter값 */

    String pis_ymd = request.getParameter("PIS_YMD_SHR");      // 년월일
    String pis_y = request.getParameter("PIS_YY_SHR");       // 년도
    String pis_m = request.getParameter("PIS_MM_SHR");      // 월도
    String pis_d = request.getParameter("PIS_DD_SHR");      // 일도
//System.out.println("guna221_ED 년월일 [" + pis_ymd + "] 년도 [" + pis_y + "] 월도 [" + pis_m + "] 일도 [" + pis_d + "]");

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_02");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
			pis_ymd,
            pis_ymd,
			pis_ymd,
			pis_ymd,
			pis_ymd
    };


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);


	/* 총계 구하기 Start */
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql2 = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_03");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind2 = new Object[] {
            pis_ymd,
			pis_ymd,
			pis_ymd,
			pis_ymd,
			pis_ymd,
			pis_ymd
    };
	AbstractDAO bbb= new AbstractDAO("default");
    DynamicValueObject voList2 = bbb.selectProcessDvo(sql2, bind2);
	DynamicValueObject vo2 = (DynamicValueObject)voList2.get(0);

	/* 총계 구하기 End */
	/* 소계(IT서비스) 구하기 Start */
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql3 = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_04");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind3 = new Object[] {
            pis_ymd,
			pis_ymd,
			pis_ymd,
			"O",
			"O",
			pis_ymd,
			pis_ymd
    };
	AbstractDAO ccc= new AbstractDAO("default");
    DynamicValueObject voList3 = ccc.selectProcessDvo(sql3, bind3);
	DynamicValueObject vo3 = (DynamicValueObject)voList3.get(0);
	/* 소계(IT서비스) 구하기 End */
	/* 소계(SI사업부) 구하기 Start */
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql4 = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_04");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind4 = new Object[] {
            pis_ymd,
			pis_ymd,
			pis_ymd,
			"D",
			"D",
			pis_ymd,
			pis_ymd
    };
	AbstractDAO ddd = new AbstractDAO("default");
    DynamicValueObject voList4 = ddd.selectProcessDvo(sql4, bind4);
	DynamicValueObject vo4 = (DynamicValueObject)voList4.get(0);
	/* 소계(SI사업부) 구하기 End */
	/* 소계(SI사업부) 구하기 Start */
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql5 = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_04");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind5 = new Object[] {
            pis_ymd,
			pis_ymd,
			pis_ymd,
			"C",
			"C",
			pis_ymd,
			pis_ymd
    };
	AbstractDAO eee = new AbstractDAO("default");
    DynamicValueObject voList5 = eee.selectProcessDvo(sql5, bind5);
	DynamicValueObject vo5 = (DynamicValueObject)voList5.get(0);
	/* 소계(SI사업부) 구하기 End */

    extquery hnwExtQuery = new extquery();


    hnwExtQuery.AddField("본부");
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("인원");
    hnwExtQuery.AddField("지각");
    hnwExtQuery.AddField("출장");
    hnwExtQuery.AddField("파견");
    hnwExtQuery.AddField("연차");
    hnwExtQuery.AddField("오전반차");
    hnwExtQuery.AddField("오후반차");
    hnwExtQuery.AddField("특휴");
    hnwExtQuery.AddField("대체휴가");
    hnwExtQuery.AddField("교육");
    hnwExtQuery.AddField("훈련");
    hnwExtQuery.AddField("결근");
    hnwExtQuery.AddField("일반휴직");
    hnwExtQuery.AddField("산재휴직");
    hnwExtQuery.AddField("산전후휴가");

    hnwExtQuery.SendField(response);

    // DynamicValueObject voList = DvoUtil.getDynamicValueObject(request, "RESULT");





	HashMap hash = new HashMap();
	Vector list = new Vector();

	//총계
	hash.put("UPDPT_NM", vo2.getString("UPDPT_NM"));     //본부
	hash.put("DPT_NM",   vo2.getString("DPT_NM"));     //부서
	hash.put("CNT",      vo2.getString("CNT"));     //인원
	hash.put("ATT_C", vo2.getString("ATT_C"));   	//합계(지각)
	hash.put("ATT_E", vo2.getString("ATT_E"));   	//합계(출장)
	hash.put("ATT_O", vo2.getString("ATT_O"));   	//합계(파견근무)
	hash.put("ATT_H", vo2.getString("ATT_H"));   	//합계(연차)
	hash.put("ATT_P", vo2.getString("ATT_P"));   	//합계(오전연반차)
	hash.put("ATT_R", vo2.getString("ATT_R"));   	//합계(오후연반차)
	hash.put("ATT_I", vo2.getString("ATT_I"));   	//합계(특휴)
	hash.put("ATT_U", vo2.getString("ATT_T"));   	//합계(대체휴가)
	hash.put("ATT_F", vo2.getString("ATT_F"));   	//합계(교육)
	hash.put("ATT_G", vo2.getString("ATT_G"));   	//합계(훈련)
	hash.put("ATT_AB", vo2.getString("ATT_AB"));     //합계(유결+무결)
	hash.put("ATT_K", vo2.getString("ATT_K"));   	//합계(휴직)
	hash.put("ATT_N", vo2.getString("ATT_N"));   	//합계(산재휴직)
	hash.put("ATT_X", vo2.getString("ATT_X"));   	//합계(산전후휴가)

	list.add(hash);
	long O_cnt = 0;
	long D_cnt = 0;
	long C_cnt = 0;
	String V_PRE_DPTNM = "";
    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
			hash = new HashMap();
			String DPT_NM = ""+vo.getString("DPT_NM");
			hash.put("UPDPT_NM", vo.getString("UPDPT_NM"));     //본부
			hash.put("DPT_NM",   vo.getString("DPT_NM"));     //부서
			hash.put("CNT",      vo.getString("CNT"));     //인원
			hash.put("ATT_C", vo.getString("ATT_C"));   	//합계(지각)
			hash.put("ATT_E", vo.getString("ATT_E"));   	//합계(출장)
			hash.put("ATT_O", vo.getString("ATT_O"));   	//합계(파견근무)
			hash.put("ATT_H", vo.getString("ATT_H"));   	//합계(연차)
			hash.put("ATT_P", vo.getString("ATT_P"));   	//합계(오전연반차)
			hash.put("ATT_R", vo.getString("ATT_R"));   	//합계(오후연반차)
			hash.put("ATT_I", vo.getString("ATT_I"));   	//합계(특휴)
			hash.put("ATT_U", vo.getString("ATT_U"));   	//합계(대체반차)
			hash.put("ATT_F", vo.getString("ATT_F"));   	//합계(교육)
			hash.put("ATT_G", vo.getString("ATT_G"));   	//합계(훈련)
			hash.put("ATT_AB",vo.getString("ATT_AB"));     //합계(유결+무결)
			hash.put("ATT_K", vo.getString("ATT_K"));   	//합계(휴직)
			hash.put("ATT_N", vo.getString("ATT_N"));   	//합계(산재휴직)
			hash.put("ATT_X", vo.getString("ATT_X"));   	//합계(산전후휴가)
			list.add(hash);
			if("O".equals(vo.getString("UPDPT_CD"))){
				if(!DPT_NM.equals(V_PRE_DPTNM)){
					O_cnt += Long.parseLong(vo.getString("CNT"));
				}
			}
			if("D".equals(vo.getString("UPDPT_CD"))){
				if(!DPT_NM.equals(V_PRE_DPTNM)){
					D_cnt += Long.parseLong(vo.getString("CNT"));
				}
			}
			if("C".equals(vo.getString("UPDPT_CD"))){
				if(!DPT_NM.equals(V_PRE_DPTNM)){
					C_cnt += Long.parseLong(vo.getString("CNT"));
				}
			}
			// IT서비스본부
			if("O".equals(vo.getString("UPDPT_CD")) && "D".equals(vo.getString("NEXT_UPDPT_CD"))){
				hash = new HashMap();
				hash.put("UPDPT_NM", vo3.getString("UPDPT_NM"));     //본부
				hash.put("DPT_NM",   vo3.getString("DPT_NM"));     //부서
				hash.put("CNT",      O_cnt+"");//vo3.getString("CNT"));     //인원
				hash.put("ATT_C", vo3.getString("ATT_C"));   	//합계(지각)
				hash.put("ATT_E", vo3.getString("ATT_E"));   	//합계(출장)
				hash.put("ATT_O", vo3.getString("ATT_O"));   	//합계(파견근무)
				hash.put("ATT_H", vo3.getString("ATT_H"));   	//합계(연차)
				hash.put("ATT_P", vo3.getString("ATT_P"));   	//합계(오전연반차)
				hash.put("ATT_R", vo3.getString("ATT_R"));   	//합계(오후연반차)
				hash.put("ATT_I", vo3.getString("ATT_I"));   	//합계(특휴)
				hash.put("ATT_U", vo3.getString("ATT_U"));   	//합계(대체반차)
				hash.put("ATT_F", vo3.getString("ATT_F"));   	//합계(교육)
				hash.put("ATT_G", vo3.getString("ATT_G"));   	//합계(훈련)
				hash.put("ATT_AB",vo3.getString("ATT_AB"));     //합계(유결+무결)
				hash.put("ATT_K", vo3.getString("ATT_K"));   	//합계(휴직)
				hash.put("ATT_N", vo3.getString("ATT_N"));   	//합계(산재휴직)
				hash.put("ATT_X", vo3.getString("ATT_X"));   	//합계(산전후휴가)
				list.add(hash);
			}
			// SI사업부
			if("D".equals(vo.getString("UPDPT_CD")) && "C".equals(vo.getString("NEXT_UPDPT_CD"))){
				hash = new HashMap();
				hash.put("UPDPT_NM", vo4.getString("UPDPT_NM"));     //본부
				hash.put("DPT_NM",   vo4.getString("DPT_NM"));     //부서
				hash.put("CNT",      D_cnt+"");//vo4.getString("CNT"));     //인원
				hash.put("ATT_C", vo4.getString("ATT_C"));   	//합계(지각)
				hash.put("ATT_E", vo4.getString("ATT_E"));   	//합계(출장)
				hash.put("ATT_O", vo4.getString("ATT_O"));   	//합계(파견근무)
				hash.put("ATT_H", vo4.getString("ATT_H"));   	//합계(연차)
				hash.put("ATT_P", vo4.getString("ATT_P"));   	//합계(오전연반차)
				hash.put("ATT_R", vo4.getString("ATT_R"));   	//합계(오후연반차)
				hash.put("ATT_I", vo4.getString("ATT_I"));   	//합계(특휴)
				hash.put("ATT_U", vo4.getString("ATT_U"));   	//합계(대체반차)
				hash.put("ATT_F", vo4.getString("ATT_F"));   	//합계(교육)
				hash.put("ATT_G", vo4.getString("ATT_G"));   	//합계(훈련)
				hash.put("ATT_AB",vo4.getString("ATT_AB"));     //합계(유결+무결)
				hash.put("ATT_K", vo4.getString("ATT_K"));   	//합계(휴직)
				hash.put("ATT_N", vo4.getString("ATT_N"));   	//합계(산재휴직)
				hash.put("ATT_X", vo4.getString("ATT_X"));   	//합계(산전후휴가)
				list.add(hash);
			}
			// 경영지원부
			if("C".equals(vo.getString("UPDPT_CD")) && "".equals(vo.getString("NEXT_UPDPT_CD"))){
				hash = new HashMap();
				hash.put("UPDPT_NM", vo5.getString("UPDPT_NM"));     //본부
				hash.put("DPT_NM",   vo5.getString("DPT_NM"));     //부서
				hash.put("CNT",      C_cnt+"");//vo5.getString("CNT"));     //인원
				hash.put("ATT_C", vo5.getString("ATT_C"));   	//합계(지각)
				hash.put("ATT_E", vo5.getString("ATT_E"));   	//합계(출장)
				hash.put("ATT_O", vo5.getString("ATT_O"));   	//합계(파견근무)
				hash.put("ATT_H", vo5.getString("ATT_H"));   	//합계(연차)
				hash.put("ATT_P", vo5.getString("ATT_P"));   	//합계(오전연반차)
				hash.put("ATT_R", vo5.getString("ATT_R"));   	//합계(오후연반차)
				hash.put("ATT_I", vo5.getString("ATT_I"));   	//합계(특휴)
				hash.put("ATT_U", vo5.getString("ATT_U"));   	//합계(대체반차)
				hash.put("ATT_F", vo5.getString("ATT_F"));   	//합계(교육)
				hash.put("ATT_G", vo5.getString("ATT_G"));   	//합계(훈련)
				hash.put("ATT_AB",vo5.getString("ATT_AB"));     //합계(유결+무결)
				hash.put("ATT_K", vo5.getString("ATT_K"));   	//합계(휴직)
				hash.put("ATT_N", vo5.getString("ATT_N"));   	//합계(산재휴직)
				hash.put("ATT_X", vo5.getString("ATT_X"));   	//합계(산전후휴가)
				list.add(hash);
			}
			V_PRE_DPTNM = DPT_NM;
		}
    }
	String pre_updptnm = "";
	String pre_dptnm = "";
	for(int i = 0; i < list.size(); i++){
		HashMap map = (HashMap)list.get(i);
		//총계
		String UPDPT_NM = ""+map.get("UPDPT_NM");
		if(pre_updptnm.equals(UPDPT_NM)){
			hnwExtQuery.AddData("");     //본부
		}else{
			hnwExtQuery.AddData(UPDPT_NM);     //본부
		}
		//소계
		String DPT_NM = ""+map.get("DPT_NM");
		if(pre_dptnm.equals(DPT_NM)){
			hnwExtQuery.AddData("");     //부서
			if(i==0){
				hnwExtQuery.AddData(""+map.get("CNT"));//인원
			}else{
				hnwExtQuery.AddData("");     //인원
			}
		}else{
			hnwExtQuery.AddData(DPT_NM);     //부서
			hnwExtQuery.AddData(""+map.get("CNT"));//인원
		}
		//hnwExtQuery.AddData(""+map.get("UPDPT_NM"));     //본부
		//hnwExtQuery.AddData(""+map.get("DPT_NM"));     //부서
		//hnwExtQuery.AddData(""+map.get("CNT"));     //인원
		hnwExtQuery.AddData(""+map.get("ATT_C"));   	//합계(지각)
		hnwExtQuery.AddData(""+map.get("ATT_E"));   	//합계(출장)
		hnwExtQuery.AddData(""+map.get("ATT_O"));   	//합계(파견근무)
		hnwExtQuery.AddData(""+map.get("ATT_H"));   	//합계(연차)
		hnwExtQuery.AddData(""+map.get("ATT_P"));   	//합계(오전연반차)
		hnwExtQuery.AddData(""+map.get("ATT_R"));   	//합계(오후연반차)
		hnwExtQuery.AddData(""+map.get("ATT_I"));   	//합계(특휴)
		hnwExtQuery.AddData(""+map.get("ATT_U"));   	//합계(대체반차)
		hnwExtQuery.AddData(""+map.get("ATT_F"));   	//합계(교육)
		hnwExtQuery.AddData(""+map.get("ATT_G"));   	//합계(훈련)
		hnwExtQuery.AddData(""+map.get("ATT_AB"));     //합계(유결+무결)
		hnwExtQuery.AddData(""+map.get("ATT_K"));   	//합계(휴직)
		hnwExtQuery.AddData(""+map.get("ATT_N"));   	//합계(산재휴직)
		hnwExtQuery.AddData(""+map.get("ATT_X"));   	//합계(산전후휴가)
		pre_updptnm = UPDPT_NM;
		pre_dptnm = DPT_NM;
		hnwExtQuery.SendData(response);

	}

%>