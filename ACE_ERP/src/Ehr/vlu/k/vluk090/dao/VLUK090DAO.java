package Ehr.vlu.k.vluk090.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class VLUK090DAO extends AbstractDAO {
	/**
	 * VLUK090DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public VLUK090DAO(String p_dsId, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);
	}

	public void VLUK090_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 평가구조설정 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SHR");

	    String JOB_CD_FROM  = p_box.get("JOB_CD_FROM");
	    String JOB_CD_TO  = p_box.get("JOB_CD_TO");
	    String GOGA1  = p_box.get("GOGA1");


		StringBuffer sb = new StringBuffer();

	    if ( !JOB_CD_FROM.equals("") && !JOB_CD_TO.equals("")) {
			 sb.append("AND ((Z.PAYGRD BETWEEN '"+JOB_CD_FROM+"' AND '"+JOB_CD_TO+"') OR (Z.PAYGRD BETWEEN '"+JOB_CD_TO+"' AND '"+JOB_CD_FROM+"'))");
	     } else if ( !JOB_CD_FROM.equals("") && JOB_CD_TO.equals("")) {
	    	 sb.append("AND Z.PAYGRD >= '"+JOB_CD_FROM+"'");
	     } else if ( JOB_CD_FROM.equals("") && !JOB_CD_TO.equals("")) {
	    	 sb.append("AND Z.PAYGRD <= '"+JOB_CD_TO+"'");
	     } else {
	    	 sb.append("AND 1=1");
	     }

		StringBuffer sb2 = new StringBuffer();

	    if ( GOGA1.equals("T")) {
			 sb2.append("AND ABS(AVG1-AVG2) > 5.00");
	     } else {
	    	 sb2.append("AND 2=2");
	     }


		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb2.toString(),
		};



		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);




		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

		//		p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
		//		p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
		//		p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
		//		p_box.get("EMPNOH"),
		//		p_box.get("EMPNOH"),
		//		p_box.get("EMPNOH"),

		};

		prop.add("SCR11", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR12", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR13", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR14", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);		
		prop.add("SCR21", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR22", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR23", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);	
		prop.add("SCR24", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);	
		prop.add("TOTAVG1", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("TOTAVG2", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("TOTAVG_FINAL", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);		
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUK090_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SHR_01");

	    String JOB_CD_FROM  = p_box.get("JOB_CD_FROM");
	    String JOB_CD_TO  = p_box.get("JOB_CD_TO");
	    String GOGA1  = p_box.get("GOGA1");

		StringBuffer sb = new StringBuffer();

	    if ( !JOB_CD_FROM.equals("") && !JOB_CD_TO.equals("")) {
			 sb.append("AND ((Z.PAYGRD BETWEEN '"+JOB_CD_FROM+"' AND '"+JOB_CD_TO+"') OR (Z.PAYGRD BETWEEN '"+JOB_CD_TO+"' AND '"+JOB_CD_FROM+"'))");
	     } else if ( !JOB_CD_FROM.equals("") && JOB_CD_TO.equals("")) {
	    	 sb.append("AND Z.PAYGRD >= '"+JOB_CD_FROM+"'");
	     } else if ( JOB_CD_FROM.equals("") && !JOB_CD_TO.equals("")) {
	    	 sb.append("AND Z.PAYGRD <= '"+JOB_CD_TO+"'");
	     } else {
	    	 sb.append("AND 1=1");
	     }

		StringBuffer sb2 = new StringBuffer();

	    if ( GOGA1.equals("T")) {
			 sb2.append("AND ABS(AVG1-AVG2) > 5.00");
	     } else {
	    	 sb2.append("AND 2=2");
	     }


		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb2.toString(),
		};


		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				//p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				//p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				//p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				//p_box.get("EMPNOH"),                       					   //
				//p_box.get("EMPNOH"),                       					   //
				//p_box.get("EMPNOH"),                       					   //
		};

		prop.add("SCR11", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR12", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR13", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR14", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);		
		prop.add("SCR21", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR22", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR23", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);	
		prop.add("SCR24", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);	
		prop.add("TOTAVG1", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("TOTAVG2", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("TOTAVG_FINAL", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);	


		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK090_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				p_box.get("EMPNOH"),                       					   //
				p_box.get("EMPNOH"),                       					   //
				p_box.get("EMPNOH"),                       					   //
		};

		prop.add("SCR1", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVG1", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR2", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVG2", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR3", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVG3", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);

		prop.add("SCRAVG", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("CORAVG", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("CORAVG2", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);		
		prop.add("DPTAVG", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("TOTAVG", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);


		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK090_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SHR_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				p_box.get("EMPNOH"),                       					   //
				p_box.get("EMPNOH"),                       					   //
				p_box.get("EMPNOH"),                       					   //
		};

		prop.add("SCR1", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVG1", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR2", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVG2", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("SCR3", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);
		prop.add("AVG3", prop.COLUMN_TYPE_DECIMAL, 5.2, prop.CONSTRAINT_TB_NORMAL);

		prop.add("SCRAVG", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("CORAVG", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("CORAVG2", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("DPTAVG", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);
		prop.add("TOTAVG", prop.COLUMN_TYPE_DECIMAL, 5.3, prop.CONSTRAINT_TB_NORMAL);


		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUK090_SHR_04(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SHR_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK090_SHR_05(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SHR_05");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	public void VLUK090_SHR_06(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SHR_06");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK090_SHR_07(CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SHR_07");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월
				p_box.get("REG_YM_SHR").replaceAll("-", ""),                       // 고과년월

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	public void VLUK090_SAV(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SAV");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GRADE2" ))
		        ,JSPUtil.rns(vo.get("GRADE3" ))
		        //,JSPUtil.rns(vo.get("EVAYM" ))
		        ,JSPUtil.rns(vo.get("EMPNO" ))

		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}

	public void VLUK090_SAV_EXE(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SAV_EXE");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("TOTAVG" ))
		        ,JSPUtil.rns(vo.get("EVAYM" ))
		        ,JSPUtil.rns(vo.get("EMPNO" ))

		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}

	public void VLUK090_SAV_GRD(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 본부별평가현황 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK090_SAV_GRD");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
		         JSPUtil.rns(vo.get("GRADE" ))
		        ,JSPUtil.rns(vo.get("GRADE" ))
		        ,JSPUtil.rns(vo.get("GRADE" ))
		        ,JSPUtil.rns(vo.get("EVAYM" ))
		        ,JSPUtil.rns(vo.get("EMPNO" ))

		};

		/** CREATE메소드 호출  **/
		this.insertProcess(sql, bind);
	}
}
