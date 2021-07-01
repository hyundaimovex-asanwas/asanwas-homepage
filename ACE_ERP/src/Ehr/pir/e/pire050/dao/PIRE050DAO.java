package Ehr.pir.e.pire050.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class PIRE050DAO extends AbstractDAO {

	/**
	 * PIRE050DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRE050DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	/**
	 * 개인정보처리 접속 기록 인사기록표 SELECT를 수행하는 DAO 메소드
	 */
	public void PIRE050_SHR_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"pire050",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}		
	
	
	
	/**
	 * 조회
	 * @param p_box
	 * @throws CException
	 */
	public void PIRE050_SHR(CBox p_box) throws CException {


		String CLAS_CD_SHR = JSPUtil.rns(p_box.get("CLAS_CD_SHR"));
		String FIELD_CD_SHR = JSPUtil.rns(p_box.get("FIELD_CD_SHR"));
		String FIELD2_CD_SHR = JSPUtil.rns(p_box.get("FIELD2_CD_SHR"));
		String FIELD3_CD_SHR = JSPUtil.rns(p_box.get("FIELD3_CD_SHR"));
		String SHAPE_CD_SHR = JSPUtil.rns(p_box.get("SHAPE_CD_SHR"));
		String JOB_CD_SHR = JSPUtil.rns(p_box.get("JOB_CD_SHR"));
		String SEX_CD_SHR = JSPUtil.rns(p_box.get("SEX_CD_SHR"));
		String YEAR_CD_SHR = JSPUtil.rns(p_box.get("YEAR_CD_SHR"));


		//System.out.print(p_box);

		String HIR_YMD_SHR = JSPUtil.rns(p_box.get("HIR_YMD_SHR"));
		String END_YMD_SHR = JSPUtil.rns(p_box.get("END_YMD_SHR"));
		String HIRG_YMD_SHR = JSPUtil.rns(p_box.get("HIRG_YMD_SHR"));
		String ENDG_YMD_SHR = JSPUtil.rns(p_box.get("ENDG_YMD_SHR"));
		String JPR_YMD_SHR = JSPUtil.rns(p_box.get("JPR_YMD_SHR"));
		String ENDJ_YMD_SHR = JSPUtil.rns(p_box.get("ENDJ_YMD_SHR"));
		String RET_YMD_SHR = JSPUtil.rns(p_box.get("RET_YMD_SHR"));
		String ENDR_YMD_SHR = JSPUtil.rns(p_box.get("ENDR_YMD_SHR"));


		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRE050_SHR");

		StringBuffer sb = new StringBuffer();

		/** 조회 조건에 따른 처리 **/
		if( CLAS_CD_SHR.equals("A") ){
			sb.append("AND A.RET_YMD IS NULL \n");
		}else 	if( CLAS_CD_SHR.equals("E") ){
			sb.append("AND A.RET_YMD IS NOT NULL \n");
		}else{

		}


		if( ! FIELD_CD_SHR.equals("") ){
			sb.append("AND  A.HEAD_CD = '"+FIELD_CD_SHR+"'   \n");
		}
		if( ! FIELD2_CD_SHR.equals("") ){
			sb.append("AND  A.DPT_CD  = '"+FIELD2_CD_SHR+"'  \n");
		}
		if( ! FIELD3_CD_SHR.equals("") ){
			sb.append("AND  A.TEAM_CD = '"+FIELD3_CD_SHR+"'  \n");
		}

		if( ! SHAPE_CD_SHR.equals("") ){
			sb.append("AND A.OCC_CD = '"+SHAPE_CD_SHR+"' \n");
		}
		if( ! JOB_CD_SHR.equals("") ){
			sb.append("AND A.JOB_CD = '"+JOB_CD_SHR+"' \n");
		}
		if( ! SEX_CD_SHR.equals("") ){
			sb.append("AND A.MF_TAG = '"+SEX_CD_SHR+"' \n");
		}
		if( ! YEAR_CD_SHR.equals("") ){
			sb.append("AND A.HOB_CD = '"+YEAR_CD_SHR+"' \n");
		}

		if(!"".equals(HIR_YMD_SHR) && !"".equals(END_YMD_SHR)) {
			sb.append("AND A.HIR_YMD BETWEEN '").append(HIR_YMD_SHR).append("' AND  '").append(END_YMD_SHR).append("' \n");
		}

		StringBuffer sb2 = new StringBuffer();

		if(!"".equals(HIRG_YMD_SHR) && !"".equals(ENDG_YMD_SHR)) {
			sb2.append("AND A.HIRG_YMD BETWEEN '").append(HIRG_YMD_SHR).append("' AND  '").append(ENDG_YMD_SHR).append("' \n");
		}

		StringBuffer sb3 = new StringBuffer();

		if(!"".equals(JPR_YMD_SHR) && !"".equals(ENDJ_YMD_SHR)) {
			sb3.append("AND A.JPR_YMD BETWEEN '").append(JPR_YMD_SHR).append("' AND  '").append(ENDJ_YMD_SHR).append("' \n");
		}

		StringBuffer sb4 = new StringBuffer();

		if(!"".equals(RET_YMD_SHR) && !"".equals(ENDR_YMD_SHR)) {
			sb4.append("AND A.RET_YMD BETWEEN '").append(RET_YMD_SHR).append("' AND  '").append(ENDR_YMD_SHR).append("' \n");
		}


		Object[] sqlParam = new Object[] {
                sb.toString(),
                sb2.toString(),
                sb3.toString(),
                sb4.toString()

        };

        sql = SqlUtils.replaceQuery(sql, sqlParam);







		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

}
