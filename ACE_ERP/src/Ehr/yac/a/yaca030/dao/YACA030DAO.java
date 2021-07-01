package Ehr.yac.a.yaca030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA030DAO extends AbstractDAO {

	/**
	 * YACA030DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 의료비공제내역 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		//prop.add("COM_NO", ColumnProp.COLUMN_TYPE_STRING, 12, ColumnProp.CONSTRAINT_TB_KEY);
		//prop.add("COM_NM", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("CARD_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("CASH_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 의료비공제내역 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("CASH_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * 의료비공제내역 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("CASH_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	
	
	/**
	 * 공제 대상자 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR_FAM(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR_FAM");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * 공제 대상자 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR_FAM_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR_FAM_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * 공제 대상자 조회
	 * @param p_box
	 * @throws CException
	 */
	public void YACA030_SHR_FAM_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_SHR_FAM_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("ENO_NO")
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING, 9, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_CD", ColumnProp.COLUMN_TYPE_STRING, 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NM", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("FAM_NO", ColumnProp.COLUMN_TYPE_STRING, 15, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * 의료비공제내역 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_INS(CBox p_box, String[][] dsArray, int i) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_INS");
		//System.out.print("p_box22222222222222222222 ================= "+p_box);
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				dsArray[i][0],//귀속녀도
				dsArray[i][1],//사원번호
				dsArray[i][2],//카드(현금영수증)
				dsArray[i][3],//진료건수
				dsArray[i][4],//현금
				dsArray[i][5],//진료건수
				dsArray[i][6],//총진료비
				dsArray[i][7].replaceAll("-", ""),//사업자등록번호
				dsArray[i][8],//진료기관명
				dsArray[i][9],//관계
				dsArray[i][10].replaceAll("-", ""),//주민번호
				dsArray[i][11],//구분
				dsArray[i][12],//의료증빙코드
				p_box.get("SESSION_ENONO"),				//입력자
				p_box.get("SESSION_ENONO")				//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	
	/**
	 * 의료비공제내역 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_INS_14(CBox p_box, String[][] dsArray, int i) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_INS_14");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				dsArray[i][0],//귀속녀도
				dsArray[i][1],//사원번호
				dsArray[i][2].replaceAll("-", ""),//사업자등록번호
				dsArray[i][3],//진료기관명
				dsArray[i][4],//관계
				dsArray[i][5].replaceAll("-", ""),//주민번호
				dsArray[i][6],//구분
				dsArray[i][7],//현금
				dsArray[i][8],//진료건수				
				dsArray[i][9],//의료증빙코드
                p_box.get("vusrid"), //입력자
                p_box.get("vusrid")  //수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}	
	
	/**
	 * 의료비공제내역 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_INS_15(CBox p_box, String[][] dsArray, int i) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_INS_15");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				dsArray[i][0],//귀속녀도
				dsArray[i][1],//사원번호
				dsArray[i][2].replaceAll("-", ""),//사업자등록번호
				dsArray[i][3],//진료기관명
				dsArray[i][4],//관계
				dsArray[i][5].replaceAll("-", ""),//주민번호
				dsArray[i][6],//구분
				dsArray[i][7],//현금
				dsArray[i][8],//진료건수				
				dsArray[i][9],//의료증빙코드
                p_box.get("vusrid"), //입력자
                p_box.get("vusrid")  //수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}	
	
	/**
	 * 의료비공제내역 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//귀속녀도
				vo.get("ENO_NO"),						//사원번호
				vo.get("COM_NO").replaceAll("-", ""),	//사업자등록번호
				vo.get("CET_NO").replaceAll("-", ""),	//주민번호
				vo.get("MED_CD").replaceAll("-", ""),	//증빙코드			
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}


	
	/**
	 * 의료비공제내역 전체 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//귀속녀도
				vo.get("ENO_NO"),						//사원번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	/**
	 * 의료비공제내역 삭제(국세청장이 제공하는 의료비의 자료경우)
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL_02(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//귀속녀도
				vo.get("ENO_NO"),					//사원번호
				vo.get("MED_CD"),					//의료증빙코드
				vo.get("CET_NO").replaceAll("-", ""),	//주민번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}
	
	/**
	 * 의료비공제내역 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL_14(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//귀속녀도
				vo.get("ENO_NO"),						//사원번호
				vo.get("COM_NO").replaceAll("-", ""),	//사업자등록번호
				vo.get("CET_NO").replaceAll("-", ""),	//주민번호
				vo.get("MED_CD").replaceAll("-", ""),	//증빙코드			
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}
	
	/**
	 * 의료비공제내역 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL_15(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//귀속녀도
				vo.get("ENO_NO"),						//사원번호
				vo.get("COM_NO").replaceAll("-", ""),	//사업자등록번호
				vo.get("CET_NO").replaceAll("-", ""),	//주민번호
				vo.get("MED_CD").replaceAll("-", ""),	//증빙코드			
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}
	
	/**
	 * 의료비공제내역 전체 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL2_14(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL2_14");		
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//귀속녀도
				vo.get("ENO_NO"),						//사원번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}	
	
	/**
	 * 의료비공제내역 전체 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL2_15(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL2_15");		
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//귀속녀도
				vo.get("ENO_NO"),						//사원번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}	
	
	/**
	 * 의료비공제내역 삭제(국세청장이 제공하는 의료비의 자료경우)
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL3_14(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL3_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//귀속녀도
				vo.get("ENO_NO"),					//사원번호
				vo.get("MED_CD"),					//의료증빙코드
				vo.get("CET_NO").replaceAll("-", ""),	//주민번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}	

	/**
	 * 의료비공제내역 삭제(국세청장이 제공하는 의료비의 자료경우)
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_DEL3_15(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_DEL3_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				vo.get("PIS_YY"),						//귀속녀도
				vo.get("ENO_NO"),					//사원번호
				vo.get("MED_CD"),					//의료증빙코드
				vo.get("CET_NO").replaceAll("-", ""),	//주민번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}	


	
	/**
	 * 의료비공제내역 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_FAM(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_FAM");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO"),
		
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 의료비공제내역 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_FAM_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_FAM_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO"),
		
		};
		
		System.out.println("YACA030_UPT_FAM_14::"+p_box.get("PIS_YY"));

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}	
	
	/**
	 * 의료비공제내역 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_FAM_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_FAM_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO"),
		
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}	
	
	
	/**
	 * 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_ACC(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_ACC");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}	
	
	
	/**
	 * 연금저축공제내역 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_ACC_14(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_ACC_14");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}		
	
	
	/**
	 * 의료비 연말정산테이블에 반영
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void YACA030_UPT_ACC_15(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA030_UPT_ACC_15");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),								//귀속녀도
				p_box.get("ENO_NO")
		};

		/** DELETE메소드 호출  **/
		updateProcess(sql, bind);
	}		
	
	
	
}
