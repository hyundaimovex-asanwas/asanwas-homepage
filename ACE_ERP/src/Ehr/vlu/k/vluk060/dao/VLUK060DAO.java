package Ehr.vlu.k.vluk060.dao;

import java.text.DecimalFormat;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class VLUK060DAO extends AbstractDAO {
	/**
	 * VLUK060DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public VLUK060DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 평가구조 설정 내용을 조회해 오는  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */

	public void VLUK060_SHR(CBox p_box) throws CException {

		//System.out.println(vo);
		//System.out.println(p_box);

		String GBMST_STR  = JSPUtil.rns(p_box.get("GBMST_STR"));

		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK060_SHR");

		StringBuffer sb = new StringBuffer();

		/** 조회 조건에 따른 처리 **/
		if( !GBMST_STR.equals("00") ){
			sb.append("AND A.GB_MST = '"+GBMST_STR+"' \n");
	     }else {
	    	 sb.append("AND 1=1");
	     }

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
			};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/

		Object[] bind = new Object[] {
			    JSPUtil.rns(p_box.get("REG_YM_SHR").replaceAll("-", "")),

		};


		/** FirstRow메소드 호출 **/
	    this.selectProcessFirstRow(sql, bind, prop);
//		this.selectProcessFirstRow(sql,  null, prop);

	}

	public void VLUK060_SHR02(CBox p_box) throws CException {

		//System.out.println(vo);
		//System.out.println(p_box);

		String GBMST_STR  = JSPUtil.rns(p_box.get("GBMST_STR"));
		String DTP_CD_SHR  = JSPUtil.rns(p_box.get("DTP_CD_SHR"));
		String JOB_CD_SHR  = JSPUtil.rns(p_box.get("JOB_CD_SHR"));
		String JIKMU_CD_SHR  = JSPUtil.rns(p_box.get("JIKMU_CD_SHR"));


		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK060_SHR02");



		StringBuffer sb = new StringBuffer();

		/** 조회 조건에 따른 처리 **/
		if( !GBMST_STR.equals("00") ){
			sb.append("AND A.GB_MST = '"+GBMST_STR+"' \n");
	     }else {
	    	 sb.append("AND 1=1");
	     }

		StringBuffer sb2 = new StringBuffer();


		if( !DTP_CD_SHR.equals("") ){
			sb2.append("AND B.HEAD_CD = '"+DTP_CD_SHR+"' \n");
	     }else {
	    	 sb2.append("AND 2=2");
	     }

		StringBuffer sb3 = new StringBuffer();

		if( !JOB_CD_SHR.equals("0") ){
			sb3.append("AND B.JOB_CD = '"+JOB_CD_SHR+"' \n");
	     }else {
	    	 sb3.append("AND 3=3");
	     }

		StringBuffer sb4 = new StringBuffer();

		if( !JIKMU_CD_SHR.equals("01") ){
			sb4.append("AND B.JIKMU_CD = '"+JIKMU_CD_SHR+"' \n");
	     }else {
	    	 sb4.append("AND 4=4");
	     }



		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb2.toString(),
				sb3.toString(),
				sb4.toString(),
			};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/

		Object[] bind = new Object[] {
			    JSPUtil.rns(p_box.get("REG_YM_SHR").replaceAll("-", "")),
			    
			    
		};


		/** FirstRow메소드 호출 **/
	    this.selectProcessFirstRow(sql, bind, prop);
//		this.selectProcessFirstRow(sql,  null, prop);

	}

	/**
	 * 평가구조 설정 내용을 저장하는  DAO메소드.
	 * @param vo			GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void VLUK060_INS_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK060_INS");

		int t_scr = Integer.parseInt(vo.get("T_SCR"));		

		/*  근무율  */
		double vg_scr = (double)t_scr*1;
		double g_scr = (double)t_scr*0.85;
		double n_scr = (double)t_scr*0.7;
		double b_scr = (double)t_scr*0.55;
		double vb_scr = (double)t_scr*0.4;		

		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("REG_YM_SHR"),		
				JSPUtil.rns(vo.get("D_GB_MST")),
				JSPUtil.rns(vo.get("D_GB_DTL")),
				
				vo.get("DTP_CD"),
				vo.get("DTP_CD"),
				vo.get("DTP_CD"),
				
				vo.get("JOB_CD"),
				vo.get("JIKMU_CD"),
				vo.get("T_SCR"),
				
				Double.toString(vg_scr),                         	// 월
				Double.toString(g_scr),                         	// 월
				Double.toString(n_scr),                         	// 월
				Double.toString(b_scr),                         	// 월
				Double.toString(vb_scr),                         	// 월				

				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	
	/**
	 * 평가구조 설정 내용을 저장하는  DAO메소드.
	 * @param vo			GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void VLUK060_INS_02(GauceValueObject vo, CBox p_box) throws CException {

		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK060_INS2");

		//System.out.println(p_box);
		//System.out.println(vo);		

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("REG_YM_SHR"),		
				JSPUtil.rns(vo.get("D_GB_MST")),
				JSPUtil.rns(vo.get("D_GB_DTL")),
				JSPUtil.rns(vo.get("D_ACT_ITEM")),				

				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);		
		
		
	}
	
	
	
	
	/**
	 * 평가구조 설정 내용을 수정하는  DAO메소드.
	 * @param vo			GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void VLUK060_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK060_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ABL_CNT")),
				JSPUtil.rns(vo.get("DOWN_YN")),
				JSPUtil.rns(vo.get("DOWN_CNT")),
				JSPUtil.rns(vo.get("UP_YN")),
				JSPUtil.rns(vo.get("UP_CNT")),
				JSPUtil.rns(vo.get("ACH_CNT")),
				JSPUtil.rns(vo.get("HEAD_YN")),
				JSPUtil.rns(vo.get("UP_RATE1")),
				JSPUtil.rns(vo.get("UP_RATE2")),
				JSPUtil.rns(vo.get("UP_RATE3")),
				JSPUtil.rns(vo.get("DOWN_RATE1")),
				JSPUtil.rns(vo.get("DOWN_RATE2")),
				JSPUtil.rns(vo.get("DOWN_RATE3")),
				JSPUtil.rns(vo.get("ACH_RATE1")),
				JSPUtil.rns(vo.get("ACH_RATE2")),
				JSPUtil.rns(vo.get("ACH_RATE3")),
				JSPUtil.rns(p_box.get("SESSION_ENONO")),
				JSPUtil.rns(vo.get("GUBUN")),
				JSPUtil.rns(vo.get("EVL_YY"))
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	
	public void VLUK060_DEL(GauceValueObject vo, CBox p_box) throws CException {

		//System.out.println(p_box);
		//System.out.println(vo);			
		
		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK060_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				vo.get("EVAYM"),	
				vo.get("GB_MST"),
				vo.get("GB_DTL"),
				vo.get("ACT_ITEM"),		
		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);
		
		/********************************/	
		/********************************/	
		/********************************/		
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql2 = XmlSqlUtils.getSQL("vlu", "VLUK060_DEL2");

		System.out.println(p_box);
		System.out.println(vo);		

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind2 = new Object[] {

				vo.get("EVAYM"),		
				vo.get("GB_MST"),
				vo.get("GB_DTL"),
				vo.get("HEAD_CD"),				

		};

		/** INSERT메소드 호출  **/
		this.deleteProcess(sql2, bind2);			
		
	
	}	
	
	public void VLUK060_DEL_01(GauceValueObject vo, CBox p_box) throws CException {
	
		
		/** 외부 XML에서 고과표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK060_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("D_EVAYM")),	
				JSPUtil.rns(vo.get("D_GB_MST")),
				JSPUtil.rns(vo.get("D_GB_DTL")),
				JSPUtil.rns(vo.get("D_ACT_ITEM")),		
		};
		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}
	
	public void VLUK060_DEL_02(GauceValueObject vo, CBox p_box) throws CException {

		//System.out.println(p_box);
		//System.out.println(vo);			
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "VLUK060_DEL2");

		//System.out.println(p_box);
		//System.out.println(vo);		

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				vo.get("D_EVAYM"),		
				vo.get("D_GB_MST"),
				vo.get("D_GB_DTL"),
				p_box.get("HEAD_CD"),				

		};

		/** INSERT메소드 호출  **/
		this.deleteProcess(sql, bind);			

	}	
	


}
