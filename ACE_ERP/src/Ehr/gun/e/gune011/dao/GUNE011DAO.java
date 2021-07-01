package Ehr.gun.e.gune011.dao;

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

public class GUNE011DAO extends AbstractDAO {

	/**
	 * GUNE011DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNE011DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 연장근무결재 현황 조회
	 * @param p_box
	 * @throws CException
	 */
	public void GUNE011_SHR(CBox p_box) throws CException {

		String STR_YMD = p_box.get("STR_YMD").replaceAll("-", "");
		String END_YMD = p_box.get("END_YMD").replaceAll("-", "");

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE011_SHR");


		/** 조회 조건(조건2)에 따른 처리 #2  상태**/
		StringBuffer sb1 = new StringBuffer();


		//상신
		if (p_box.get("GBN").equals("2")) {
			sb1.append("AND    B.APP_YN = 'N'\n");
			sb1.append("AND    B.APP_STATUS LIKE '상신%' \n");
		}

		//결재완료
		else if (p_box.get("GBN").equals("3")) {
			sb1.append("AND    B.APP_YN = 'Y'");

		//ALL
		}else {
			
			sb1.append("");
			
		}


		StringBuffer sb3 = new StringBuffer();

		String vusrid = JSPUtil.rns(p_box.get("vusrid"));

		//System.out.println("==================="+p_box);
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vfdname")));	
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vusrnm")));		
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vconame")));			
		//System.out.println("==================="+JSPUtil.rns(p_box.getString("vdeptnm")));		
		
		
		if(!p_box.get("vusrid").equals("6060002") && !p_box.get("vusrid").equals("6180001") && !p_box.get("vusrid").equals("2070020")){
			 sb3.append("AND   (A.PENO_NO = '"+ vusrid + "' OR A.ENO_NO = '"+ vusrid +"') \n");
		}else{

		}


		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb1.toString(),
				//sb2.toString(),
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
	public void GUNE011_DEL_01(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "GUNE011_DEL_01");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("REQ_NO"),
				vo.get("ENO_NO")
		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}

	


}

