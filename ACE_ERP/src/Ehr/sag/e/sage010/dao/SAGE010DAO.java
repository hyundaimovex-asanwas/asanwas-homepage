package Ehr.sag.e.sage010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SAGE010DAO extends AbstractDAO {

	/**
	 * SAGD010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGE010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGE010_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE010_SHR");

		//System.out.print(">>>>>>>>>>>>>>>>>>  PIS_YM = " +p_box.get("PIS_YM"));

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM").substring(0, 4),
				p_box.get("PIS_YM").substring(5, 7),
				p_box.get("SITE_CD"),
				p_box.get("SITE_CD"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YM").replaceAll("-", ""),

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 소속 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGE010_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE010_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),//입력자
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}



	/**
	 * 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGE010_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE010_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("JOB_CD")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns3(vo.get("BAS_AMT")),
				JSPUtil.rns3(vo.get("DUTY_AMT")),
				JSPUtil.rns3(vo.get("LAW_AMT")),
				JSPUtil.rns3(vo.get("BNS_AMT")),
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(p_box.get("vusrid"))//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 급여테이블 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGE010_UPT(CBox p_box, GauceValueObject vo) throws CException {

		int ATT_H = 0;
		int ATT_W = 0;



		for(int i=1;i<=31;i++){
			if(vo.get("AT"+i+"_CD").equals("O")){
				ATT_W = ATT_W + 1;
			}else if(vo.get("AT"+i+"_CD").equals("X")){
				ATT_H = ATT_H + 1;
			}else if(vo.get("AT"+i+"_CD").equals("Y")){
				ATT_H = ATT_H + 1;
			}
		}


		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE010_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("AT1_CD"),
				vo.get("AT2_CD"),
				vo.get("AT3_CD"),
				vo.get("AT4_CD"),
				vo.get("AT5_CD"),
				vo.get("AT6_CD"),
				vo.get("AT7_CD"),
				vo.get("AT8_CD"),
				vo.get("AT9_CD"),
				vo.get("AT10_CD"),
				vo.get("AT11_CD"),
				vo.get("AT12_CD"),
				vo.get("AT13_CD"),
				vo.get("AT14_CD"),
				vo.get("AT15_CD"),
				vo.get("AT16_CD"),
				vo.get("AT17_CD"),
				vo.get("AT18_CD"),
				vo.get("AT19_CD"),
				vo.get("AT20_CD"),
				vo.get("AT21_CD"),
				vo.get("AT22_CD"),
				vo.get("AT23_CD"),
				vo.get("AT24_CD"),
				vo.get("AT25_CD"),
				vo.get("AT26_CD"),
				vo.get("AT27_CD"),
				vo.get("AT28_CD"),
				vo.get("AT29_CD"),
				vo.get("AT30_CD"),
				vo.get("AT31_CD"),
				Integer.toString(ATT_H),
				Integer.toString(ATT_W),
				p_box.get("vusrid"),
				vo.get("PIS_YYMM").substring(0, 4),
				vo.get("PIS_YYMM").substring(5, 7),
				vo.get("ENO_NO"),
		};
		/** INSERT메소드 호출  **/
		updateProcess(sql, bind);

	}


}
