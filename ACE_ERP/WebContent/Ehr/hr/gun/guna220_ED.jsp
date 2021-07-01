<!--
***********************************************************************
* @source      : guna220_ED.jsp
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

    String pis_y = request.getParameter("PIS_YY_SHR");      // 일자
    String pis_m = request.getParameter("PIS_MM_SHR");      // 일자

    System.out.println("guna220_ED  년도 [" + pis_y + "] 월도 [" + pis_m + "]");
    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("gun", "GUNA220_SHR_01");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
            pis_y,
			pis_m
    };


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

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
    hnwExtQuery.AddField("대휴반차");
    hnwExtQuery.AddField("교육");
    hnwExtQuery.AddField("훈련");
    hnwExtQuery.AddField("결근");
    hnwExtQuery.AddField("일반휴직");
    hnwExtQuery.AddField("산재휴직");
    hnwExtQuery.AddField("산전후휴가");

    hnwExtQuery.SendField(response);

    // DynamicValueObject voList = DvoUtil.getDynamicValueObject(request, "RESULT");


	String pre_nm = "";
	String nm = "";
    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
/*
	C.DPT_NM AS UP_DPT_NM
	,B.DPT_CD
	,B.DPT_NM
	,A.ATT_A    --합계(유결)
	,A.ATT_B   	--합계(무결)
	,A.ATT_C   	--합계(지각)
	,A.ATT_D   	--합계(조퇴)
	,A.ATT_E   	--합계(출장)
	,A.ATT_F   	--합계(교육)
	,A.ATT_G   	--합계(훈련)
	,A.ATT_H   	--합계(연차)
	,A.ATT_I   	    --합계(특휴)
	,A.ATT_J   	--합계(여휴)
	,A.ATT_K   	--합계(휴직)
	,A.ATT_L   	--합계(기타)
	,A.ATT_N   	--합계(산재휴직)
	,A.ATT_O   	--합계(파견근무)
	,A.ATT_P   	--합계(오전연반차)
	,A.ATT_R   	--합계(오후연반차)
	,A.ATT_S   	--합계(유급)
	,A.ATT_U   	--합계(대체반차)
	,A.ATT_X   	--합계(산전후휴가)
	,A.ATW_CNT 	--정상근무
	,A.HOL_CNT 	--휴일
	,A.HOW_CNT 	--휴일근무(대체휴가)
*/
				String UPDPT_NM = vo.getString("UPDPT_NM");
				if(pre_nm.equals(UPDPT_NM)){
					hnwExtQuery.AddData("");     //본부
				}else{
					hnwExtQuery.AddData(UPDPT_NM);     //본부
				}

				hnwExtQuery.AddData(vo.getString("DPT_NM"));     //부서
				hnwExtQuery.AddData(vo.getString("CNT"));     //인원
				hnwExtQuery.AddData(vo.getString("ATT_C"));   	//합계(지각)
				hnwExtQuery.AddData(vo.getString("ATT_E"));   	//합계(출장)
				hnwExtQuery.AddData(vo.getString("ATT_O"));   	//합계(파견근무)
				hnwExtQuery.AddData(vo.getString("ATT_H"));   	//합계(연차)
				hnwExtQuery.AddData(vo.getString("ATT_P"));   	//합계(오전연반차)
				hnwExtQuery.AddData(vo.getString("ATT_R"));   	//합계(오후연반차)
				hnwExtQuery.AddData(vo.getString("ATT_I"));   	//합계(특휴)
				hnwExtQuery.AddData(vo.getString("ATT_T"));   	//합계(대체반차)
				hnwExtQuery.AddData(vo.getString("ATT_F"));   	//합계(교육)
				hnwExtQuery.AddData(vo.getString("ATT_G"));   	//합계(훈련)
				hnwExtQuery.AddData(vo.getString("ATT_AB"));     //합계(유결+무결)
				hnwExtQuery.AddData(vo.getString("ATT_K"));   	//합계(휴직)
				hnwExtQuery.AddData(vo.getString("ATT_N"));   	//합계(산재휴직)
				hnwExtQuery.AddData(vo.getString("ATT_X"));   	//합계(산전후휴가)
				pre_nm = UPDPT_NM;

				/*
				hnwExtQuery.AddData(vo.getString("ATT_A"));     //합계(유결)
				hnwExtQuery.AddData(vo.getString("ATT_B"));   	//합계(무결)
				hnwExtQuery.AddData(vo.getString("ATT_D"));   	//합계(조퇴)
				hnwExtQuery.AddData(vo.getString("ATT_J"));   	//합계(여휴)
				hnwExtQuery.AddData(vo.getString("ATT_L"));   	//합계(기타)
				hnwExtQuery.AddData(vo.getString("ATT_S"));   	//합계(유급)
				hnwExtQuery.AddData(vo.getString("ATW_CNT")); 	//정상근무
				hnwExtQuery.AddData(vo.getString("HOL_CNT")); 	//휴일
				hnwExtQuery.AddData(vo.getString("HOW_CNT")); 	//휴일근무(대체휴가)
				*/

            hnwExtQuery.SendData(response);
		}
    }

%>