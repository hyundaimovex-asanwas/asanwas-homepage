package Ehr.but.a.buta010.dao;

import java.io.FileOutputStream;
import java.io.IOException;

import com.gauce.GauceDataSet;
import com.shift.gef.configuration.Configuration;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.JSPUtil;

public class BUTA010DAO extends AbstractDAO {

	/**
	 * BUTA010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BUTA010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 출장품의 현황 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA010_SHR(CBox p_box) throws CException {

		String STR_YMD = p_box.get("STR_YMD").replaceAll("-", "");
		String END_YMD = p_box.get("END_YMD").replaceAll("-", "");

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_SHR");


		/** 조회 조건(조건2)에 따른 처리 #2  상태**/
		StringBuffer sb1 = new StringBuffer();


		//상신
		if (p_box.get("GBN2").equals("2")) {
			sb1.append("AND    B.APP_COMP = 'N'\n");
			sb1.append("AND    B.APP_CMT LIKE '상신%' \n");
		}
		
		
		//결재완료
		else if (p_box.get("GBN2").equals("3")) {
			sb1.append("AND    B.APP_COMP = 'Y'");
			
			
		//부결
		}else if (p_box.get("GBN2").equals("4")) {
			sb1.append("AND    B.APP_COMP = 'N'\n");
			sb1.append("AND    B.APP_CMT LIKE '부결%' \n");
			
			
		//반송
		}else if (p_box.get("GBN2").equals("5")) {
			sb1.append("AND    B.APP_COMP = 'N'\n");
			sb1.append("AND    B.APP_CMT LIKE '반송%' \n");

			
		//ALL
		}else {
			
			sb1.append("");
			
		}

		/** 조회 조건(조건1)에 따른 처리 #3 **/
		StringBuffer sb2 = new StringBuffer();

		if (p_box.get("GBN1").equals("3")) {
			
			sb2.append("AND    A.APP_YN <> 'Y'\n");
		}
		
		else if (p_box.get("GBN1").equals("2")) {
			
			sb2.append("AND    A.APP_YN = 'Y'\n");
			
		}else {
			
			sb2.append("");
			
		}

		/* 기전 김민규씨&현성빈씨 출장품의서 목록 조회할수있게 반영 20140630 */
		StringBuffer sb3 = new StringBuffer();

		String vusrid = JSPUtil.rns(p_box.get("vusrid"));

		//System.out.println("==================="+p_box);
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vfdname")));	
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vusrnm")));		
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vconame")));			
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vdeptnm")));		
		
		
		if(!p_box.get("vusrid").equals("6180022") && !p_box.get("vusrid").equals("2130010") && !p_box.get("vusrid").equals("6060002") && !p_box.get("vusrid").equals("2130013") &&  !p_box.get("vusrid").equals("2180001")  && !p_box.get("vusrid").equals("2070020")&& !p_box.get("vusrid").equals("6180001") && !p_box.get("vusrid").equals("2200022")){
			 sb3.append("AND   (PENO_NO = '"+ vusrid + "' OR A.ENO_NO = '"+ vusrid +"') \n");
		}else{
			 sb2.append("AND   1 =1  \n");
		}


		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb1.toString(),
				sb2.toString(),
				sb3.toString(),

		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),
				p_box.get("OUR_MAN"),
				STR_YMD,
				END_YMD,
				STR_YMD,
				END_YMD,
		};
		prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
     * 출장품의서 삭제 DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA010_DEL_01(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_DEL_01");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("REQ_NO"),
				vo.get("PENO_NO")
		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}

	/**
     * 출장품의서결재현황 삭제 DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA010_DEL_02(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_DEL_02");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("REQ_NO"),
				vo.get("PENO_NO")
		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}

	/**
     * 여비계산서 삭제 DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA010_DEL_03(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_DEL_03");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("REQ_NO")
		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}

	/**
     * 출장결재자정보 삭제 DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA010_DEL_04(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_DEL_04");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("REQ_NO")
		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}


}

