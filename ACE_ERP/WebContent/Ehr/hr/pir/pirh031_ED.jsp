<!--
***********************************************************************
* @source      : pirh031_ED.jsp
* @description : 직급별,근속년수별 인원현황
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/03/25     방석호        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import ="com.shift.gef.core.exception.CException"%>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"%>
<%@page import ="com.shift.gef.gauce.utility.TrBox"%>
<%@page import ="com.shift.gef.support.collection.CBox"%>

<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>
<%@page import=" java.util.StringTokenizer"   %>


<%
	String HIR_YMD_SHR = request.getParameter("HIR_YMD_SHR").replaceAll("-", "");
	String OCC_CD_SHR  = request.getParameter("OCC_CD_SHR");
	String GBN_CD_SHR  = request.getParameter("GBN_CD_SHR");  // 본사, 지방
	String FLAG_SHR = request.getParameter("FLAG_SHR");       // 당사(HIR), GROUP(HIRG)
	String HIR_SHR  = request.getParameter("HIR_SHR");

	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	Object[] bind = new Object[] {};

	StringBuffer sb = new StringBuffer();

	/** 조회 조건에 따른 처리 **/
	if( ! GBN_CD_SHR.equals("0") ){
		if( GBN_CD_SHR.equals("1") ){
			sb.append("AND GBN_CD  = '1' \n"); // 본사 만
		}else{
			sb.append("AND GBN_CD != '1' \n"); // 본사(1) 가 아닌 모두
		}
	}
	if( ! OCC_CD_SHR.equals("0") ){
		sb.append("AND OCC_CD = '"+OCC_CD_SHR+"' \n");
	}
	if( ! HIR_YMD_SHR.equals("") ){
		sb.append("AND TO_CHAR("+FLAG_SHR+"_YMD,'YYYYMMDD') <= '"+HIR_YMD_SHR+"' \n");
	}

	// 1|1|3|4|10|15|20  으로 전달됨
	StringTokenizer tkn = new StringTokenizer(HIR_SHR, "|");
	StringTokenizer tknCp = new StringTokenizer(HIR_SHR, "|");

	int cnt = 0;
	while(tkn.hasMoreTokens()){
		tkn.nextToken();
		cnt++;
	}

	// 조회조건 근속년수 필드 갯수에 따른 배열 생성 대입
	String[] arrCon = new String[]{"","","","","","",""};  // default

	for(int i=0; i<cnt; i++){
		arrCon[i] = tknCp.nextToken();
	}
	String sql = "";
	String colnm = "";

	String[] arrCol = new String[]{
			"HIR_03,",
			"HIR_04,",
			"HIR_05,",
			"HIR_06,",
			"HIR_07,",
	};
	colnm = "RN,JOB_NM,HIR_TOT,HIR_AVG,HIR_01,HIR_02,";

	sql += "SELECT  DECODE(J.NO, 1, RN   , '') AS RN  \n";
	sql += "       ,DECODE(J.NO, 1, JOB_NM   , '') AS JOB_NM  \n";
	sql += "       ,DECODE(J.NO, 1, HIR_TOT  , ROUND( (HIR_TOT/(MAX(HIR_TOT) OVER (PARTITION BY J.NO) )* 100),1)) AS HIR_TOT  \n";
	sql += "       ,DECODE(J.NO, 1, FLOOR((HIR_MON/HIR_TOT)/12) ||'년 '|| FLOOR(MOD(HIR_MON/HIR_TOT,12))||'개월', '') AS HIR_AVG  \n";
	sql += "       ,DECODE(J.NO, 1, DECODE(HIR_01, NULL, '', HIR_01) , DECODE(HIR_01, NULL, '', ROUND( (HIR_01/HIR_TOT)*100,1)||'%') ) AS HIR_01  \n";
	sql += "       ,DECODE(J.NO, 1, DECODE(HIR_02, NULL, '', HIR_02) , DECODE(HIR_02, NULL, '', ROUND( (HIR_02/HIR_TOT)*100,1)||'%') ) AS HIR_02  \n";

	String[] arrSel_01 = new String[]{
			"       ,DECODE(J.NO, 1, DECODE(HIR_03, NULL, '', HIR_03) , DECODE(HIR_03, NULL, '', ROUND( (HIR_03/HIR_TOT)*100,1)||'%') ) AS HIR_03 \n",
			"       ,DECODE(J.NO, 1, DECODE(HIR_04, NULL, '', HIR_04) , DECODE(HIR_04, NULL, '', ROUND( (HIR_04/HIR_TOT)*100,1)||'%') ) AS HIR_04 \n",
			"       ,DECODE(J.NO, 1, DECODE(HIR_05, NULL, '', HIR_05) , DECODE(HIR_05, NULL, '', ROUND( (HIR_05/HIR_TOT)*100,1)||'%') ) AS HIR_05 \n",
			"       ,DECODE(J.NO, 1, DECODE(HIR_06, NULL, '', HIR_06) , DECODE(HIR_06, NULL, '', ROUND( (HIR_06/HIR_TOT)*100,1)||'%') ) AS HIR_06 \n",
			"       ,DECODE(J.NO, 1, DECODE(HIR_07, NULL, '', HIR_07) , DECODE(HIR_07, NULL, '', ROUND( (HIR_07/HIR_TOT)*100,1)||'%') ) AS HIR_07 \n"
	};

	for(int a=0; a<cnt-2; a++){
		sql += arrSel_01[a];
		colnm += arrCol[a];
	}

	sql += "FROM (  \n";
	sql += "      SELECT  DECODE(L.NO, 1, ROW_NUMBER() OVER(ORDER BY L.NO), '') RN  \n";
	sql += "             ,DECODE(L.NO, 1, K.JOB_SEQ, 999)  AS JOB_SEQ  \n";
	sql += "             ,DECODE(L.NO, 1, K.JOB_NM, '합계') AS JOB_NM  \n";
	sql += "             ,DECODE(L.NO, 1, SUM(K.HIR_MON), SUM(K.HIR_MON) ) AS HIR_MON  \n";
	sql += "             ,SUM(K.HIR_TOT) AS HIR_TOT  \n";
	sql += "             ,SUM(K.HIR_01)  AS HIR_01  \n";
	sql += "             ,SUM(K.HIR_02)  AS HIR_02  \n";

	String[] arrSel_02 = new String[]{
			"             ,SUM(K.HIR_03)  AS HIR_03 \n",
			"             ,SUM(K.HIR_04)  AS HIR_04 \n",
			"             ,SUM(K.HIR_05)  AS HIR_05 \n",
			"             ,SUM(K.HIR_06)  AS HIR_06 \n",
			"             ,SUM(K.HIR_07)  AS HIR_07 \n"
	};

	for(int b=0; b<cnt-2; b++){
		sql += arrSel_02[b];
	}

	sql += "      FROM ( \n";
	sql += "            SELECT A.JOB_NM, A.JOB_SEQ, A.HIR_TOT \n";
	sql += "                  ,( DECODE(B.HIR_MON,NULL,0,B.HIR_MON) \n";
	sql += "                   + DECODE(C.HIR_MON,NULL,0,C.HIR_MON) \n";
	String[] arrSel_03 = new String[]{
			"                   + DECODE(D.HIR_MON,NULL,0,D.HIR_MON) \n",
			"                   + DECODE(E.HIR_MON,NULL,0,E.HIR_MON) \n",
			"                   + DECODE(F.HIR_MON,NULL,0,F.HIR_MON) \n",
			"                   + DECODE(G.HIR_MON,NULL,0,G.HIR_MON) \n",
			"                   + DECODE(H.HIR_MON,NULL,0,H.HIR_MON) \n"
	};
	for(int c=0; c<cnt-2; c++){
		sql += arrSel_03[c];
	}
	sql += "                    ) AS HIR_MON  \n";
	sql += "                  ,B.HIR_01  \n";
	sql += "                  ,C.HIR_02  \n";

	String[] arrSel_04 = new String[]{
			"                  ,D.HIR_03 \n",
			"                  ,E.HIR_04 \n",
			"                  ,F.HIR_05 \n",
			"                  ,G.HIR_06 \n",
			"                  ,H.HIR_07 \n"
	};
	for(int j=0; j<cnt-2; j++){
		sql += arrSel_04[j];
	}

	sql += "            FROM (  SELECT JOB_NM, MAX(JOB_SEQ) AS JOB_SEQ, COUNT(*) AS HIR_TOT  \n";
	sql += "                    FROM   VI_T_CM_PERSON  \n";
	sql += "                    WHERE  1=1  \n";
	sql += "                    [1]  \n";
	sql += "                    GROUP BY  JOB_NM  \n";
	sql += "                   ) A  \n";
	sql += "                 ,( SELECT JOB_NM, COUNT(*) HIR_01, SUM(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)) AS HIR_MON  \n";
	sql += "                    FROM   VI_T_CM_PERSON  \n";
	sql += "                    WHERE  FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 < "+arrCon[0]+"  \n";
	sql += "                    [2]  \n";
	sql += "                    GROUP BY JOB_NM  \n";
	sql += "                   ) B  \n";
	sql += "                 ,( SELECT JOB_NM, COUNT(*) AS HIR_02, SUM(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)) AS HIR_MON  \n";
	sql += "                    FROM   VI_T_CM_PERSON  \n";
	sql += "                    WHERE  FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1+1 >= "+arrCon[1]+"  \n";
	if(arrCon[2] != ""){
		sql += "                AND    FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 < "+arrCon[2]+"  \n";
	}
	sql += "                    [3]  \n";
	sql += "                    GROUP BY JOB_NM  \n";
	sql += "                   ) C  \n";

	// 조회할 인라인 뷰
	String tblD = "";
	tblD += "            ,( SELECT JOB_NM, COUNT(*) AS HIR_03, SUM(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)) AS HIR_MON  \n";
	tblD += "               FROM   VI_T_CM_PERSON  \n";
	tblD += "               WHERE  FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 >= "+arrCon[2]+"  \n";
	if(arrCon[3] != ""){
		tblD += "           AND    FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 < "+arrCon[3]+"  \n";
	}
	tblD += "               [4]  \n";
	tblD += "               GROUP BY JOB_NM  \n";
	tblD += "               ) D  \n";

	String tblE = "";
	tblE += "            ,( SELECT JOB_NM, COUNT(*) AS HIR_04, SUM(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)) AS HIR_MON  \n";
	tblE += "               FROM   VI_T_CM_PERSON  \n";
	tblE += "               WHERE  FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 >= "+arrCon[3]+"  \n";
	if(arrCon[4] != ""){
		tblE += "           AND    FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 < "+arrCon[4]+"  \n";
	}
	tblE += "               [5]  \n";
	tblE += "               GROUP BY JOB_NM  \n";
	tblE += "               ) E  \n";

	String tblF = "";
	tblF += "            ,( SELECT JOB_NM, COUNT(*) AS HIR_05, SUM(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)) AS HIR_MON  \n";
	tblF += "               FROM   VI_T_CM_PERSON  \n";
	tblF += "               WHERE  FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 >= "+arrCon[4]+"  \n";
	if(arrCon[5] != ""){
		tblF += "           AND    FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 < "+arrCon[5]+"  \n";
	}
	tblF += "               [6]  \n";
	tblF += "               GROUP BY JOB_NM  \n";
	tblF += "               ) F  \n";

	String tblG = "";
	tblG += "            ,( SELECT JOB_NM, COUNT(*) AS HIR_06, SUM(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)) AS HIR_MON  \n";
	tblG += "               FROM   VI_T_CM_PERSON  \n";
	tblG += "               WHERE  FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 >= "+arrCon[5]+"  \n";
	if(arrCon[6] != ""){
		tblG += "           AND    FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 < "+arrCon[6]+"  \n";
	}
	tblG += "               [7]  \n";
	tblG += "               GROUP BY JOB_NM  \n";
	tblG += "               ) G  \n";

	String tblH = "";
	tblH += "            ,( SELECT JOB_NM, COUNT(*) AS HIR_07, SUM(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)) AS HIR_MON  \n";
	tblH += "               FROM   VI_T_CM_PERSON  \n";
	tblH += "               WHERE  FLOOR(MONTHS_BETWEEN('"+HIR_YMD_SHR+"', "+FLAG_SHR+"_YMD)/12)+1 >= "+arrCon[6]+"  \n";
	tblH += "               [8]  \n";
	tblH += "               GROUP BY JOB_NM  \n";
	tblH += "               ) H  \n";

	String[] arrTbl = new String[]{
			tblD,
			tblE,
			tblF,
			tblG,
			tblH,
	};
	for(int k=0; k<cnt-2; k++){
		sql += arrTbl[k];
	}

	sql += "            WHERE  A.JOB_NM = B.JOB_NM(+)  \n";
	sql += "            AND    A.JOB_NM = C.JOB_NM(+)  \n";

	String[] arrJoin = new String[]{
			"               AND    A.JOB_NM = D.JOB_NM(+)  \n",
			"               AND    A.JOB_NM = E.JOB_NM(+)  \n",
			"               AND    A.JOB_NM = F.JOB_NM(+)  \n",
			"               AND    A.JOB_NM = G.JOB_NM(+)  \n",
			"               AND    A.JOB_NM = H.JOB_NM(+)  \n"
	};
	for(int l=0; l<cnt-2; l++){
		sql += arrJoin[l];
	}

	sql += "            ORDER  BY JOB_SEQ  \n";
	sql += "           ) K,  \n";
	sql += "          ( SELECT 1 AS NO FROM DUAL UNION ALL  \n";
	sql += "            SELECT 2 AS NO FROM DUAL   \n";
	sql += "           ) L    \n";
	sql += "      GROUP BY L.NO, DECODE(L.NO, 1, K.JOB_SEQ, 999), DECODE(L.NO, 1, K.JOB_NM, '합계')  \n";
	sql += "     ) I,  \n";
	sql += "    ( SELECT 1 AS NO FROM DUAL UNION ALL  \n";
	sql += "      SELECT 2 AS NO FROM DUAL   \n";
	sql += "     ) J   \n";
	sql += "  ORDER BY I.JOB_SEQ   \n";

	/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
	Object[] sqlParam = new Object[] {
			sb.toString(),
			sb.toString(),
			sb.toString(),
			sb.toString(),
			sb.toString(),
			sb.toString(),
			sb.toString(),
			sb.toString()
	};

	/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
	sql = SqlUtils.replaceQuery(sql, sqlParam);

    AbstractDAO aaa= new AbstractDAO("default");

    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


/** 필드값 세팅 **/
	String 	colStr  =   colnm;
	String[] values = colStr.split(",");
	for( int x = 0; x < values.length; x++ ){
		hnwExtQuery.AddField(values[x]);
	}
    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for (int i=0; i<voList.size(); i++)
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

        	for( int x = 0; x < values.length; x++ ){
                hnwExtQuery.AddData(vo.getString(values[x]));
        	}
            hnwExtQuery.SendData(response);
        }
    }
    else
    {
    	// hnwExtQuery.AddData("데이터가 존재하지 않습니다.");
    	for( int x = 0; x < values.length; x++ ){
            hnwExtQuery.AddData("");
    	}
        hnwExtQuery.SendData(response);

    }
%>