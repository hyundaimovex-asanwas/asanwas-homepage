package Ehr.cod.b.codb020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODB020DAO extends AbstractDAO {

	/**
	 * CODB010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODB020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 트리구성을 위한 부서 조회
	 * @param p_box
	 * @throws CException
	 */
	public void CODB020_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 상위 부서코드에 따른 하위 부서코드 상세 조회
	 * @param p_box
	 * @throws CException
	 */
	public void CODB020_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("COUNT_REM"),
				p_box.get("COUNT_REM")+"%"
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
	/**
	 * HEAD_TAG 목록 조회
	 * @param p_box
	 * @throws CException
	 */
	public void CODB020_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * 부서정보가 하나도 없으면 회사정보를 넣는다.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODB020_INS(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(p_box.get("vusrid")),//수정자

		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 부서정보 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODB020_INS_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_INS_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("DPT_CD")),//pk

				JSPUtil.rns(vo.get("DPT_NM")),
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("UPDPT_CD")),

				JSPUtil.rns(vo.get("DPT_LBL")),
				JSPUtil.rns(vo.get("SORT_NO")),
				JSPUtil.rns3(vo.get("COUNT_REM")),
				JSPUtil.rns3(vo.get("GBN2_TAG")),

				JSPUtil.rns3(vo.get("PART_CD")),
				JSPUtil.rns3(vo.get("REMARK")),
				JSPUtil.rns3(vo.get("REMARK2")),
				JSPUtil.rns3(vo.get("REMARK3")),
				JSPUtil.rns3(vo.get("HEAD_CD")),
				JSPUtil.rns3(vo.get("GBN_CD")),
				JSPUtil.rns3(vo.get("OFFICE")),
				JSPUtil.rns3(vo.get("HEAD_TAG")),
				JSPUtil.rns3(vo.get("REG_CD")),
				JSPUtil.rns3(vo.get("COM_NO")),

				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(p_box.get("vusrid"))//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 부서정보 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODB020_UPT_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_UPT_01");
		
		System.out.print(vo);
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(vo.get("DPT_NM")),
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("UPDPT_CD")),

				JSPUtil.rns(vo.get("DPT_LBL")),
				JSPUtil.rns(vo.get("SORT_NO")),
                JSPUtil.rns(vo.get("COUNT_REM")),
                JSPUtil.rns(vo.get("GBN2_TAG")),

                JSPUtil.rns(vo.get("PART_CD")),
                JSPUtil.rns(vo.get("REMARK")),
                JSPUtil.rns(vo.get("REMARK2")),
                JSPUtil.rns(vo.get("REMARK3")),
                JSPUtil.rns(vo.get("HEAD_CD")),
                JSPUtil.rns(vo.get("GBN_CD")),
                JSPUtil.rns(vo.get("OFFICE")),
                JSPUtil.rns(vo.get("HEAD_TAG")),
                JSPUtil.rns(vo.get("REG_CD")),
                JSPUtil.rns(vo.get("COM_NO")),

				JSPUtil.rns(p_box.get("vusrid")),//수정자

				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("DPT_CD")),//pk
		};
		
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
		
	}

	/**
	 * 상위부서의 하위부서유무 update한다.(상위부서에 하위부서 있다고 update)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODB020_UPT_02(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_UPT_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(Integer.toString(Integer.parseInt(vo.get("DPT_LBL"))-1)),//상위레벨
				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)),//상위 countremark
		};
		
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
		
	}

	/**
	 * 상위부서의 하위부서유무 update한다.(상위부서에 하위부서 없다고 update)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODB020_UPT_03(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_UPT_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)),//상위 countremark
				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)+"%"),//상위 countremark
		};
		/** UPDATE메소드 호출  **/
		//updateProcess(sql, bind);
		deleteProcess(sql, bind);//업데이트되는 row가 0이어도 저장이 되게 하기위해 deleteProcess을 사용
	}

	/**
	 * 부서정보 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODB020_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODB020_DEL_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("CD_GBN")),//pk
				JSPUtil.rns(vo.get("DPT_CD")),//pk
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

}
