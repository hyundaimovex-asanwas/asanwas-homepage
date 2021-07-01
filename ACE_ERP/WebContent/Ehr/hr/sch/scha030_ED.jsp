<!--
***********************************************************************
* @source      : .jsp
* @description : 학자금신청서 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/12/28      권혁수        최초작성.
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

    String print_no = request.getParameter("PRINT_NO");      // 결재번호
	//print_no = "2009O20001";

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_02");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
            print_no
    };


    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


    hnwExtQuery.AddField("본부");
    hnwExtQuery.AddField("부서");
    hnwExtQuery.AddField("직위");
    hnwExtQuery.AddField("성명");
    hnwExtQuery.AddField("성");
    hnwExtQuery.AddField("자녀성명");
    hnwExtQuery.AddField("주민등록번호");
    hnwExtQuery.AddField("학교");
    hnwExtQuery.AddField("학년");
    hnwExtQuery.AddField("지급학자금");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0) 
    {
        for (int i=0; i<voList.size(); i++) 
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);
			hnwExtQuery.AddData(vo.getString("UPDPT_NM"));     //본부
			hnwExtQuery.AddData(vo.getString("DPT_NM"));		//부서
			hnwExtQuery.AddData(vo.getString("JOB_NM"));   	//직위
			hnwExtQuery.AddData(vo.getString("ENO_NM"));   	//성명
			hnwExtQuery.AddData(vo.getString("MF_TAG_NM"));   	//성
			hnwExtQuery.AddData(vo.getString("SEL_NM"));   	//성명
			hnwExtQuery.AddData(vo.getString("BIR_YMD"));   	//주민등록번호
			hnwExtQuery.AddData(vo.getString("SCH_NM"));   	//학교
			hnwExtQuery.AddData(vo.getString("FSCH_NM"));   	//학년
			hnwExtQuery.AddData(vo.getString("TOT_AMT"));   	//지급학자금
            hnwExtQuery.SendData(response);				
		}
    }

%>