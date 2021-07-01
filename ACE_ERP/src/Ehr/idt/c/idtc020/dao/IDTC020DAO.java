package Ehr.idt.c.idtc020.dao;


import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class IDTC020DAO extends AbstractDAO {
	
	/**
	 * IDTC020DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTC020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	
	/**
	 * 주간업무보고 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC020_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC020_SHR");

		int WEEK_NO2 = Integer.parseInt(p_box.get("WEEK_NO")) + 1 ;	
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("WEEK_NO"),
				p_box.get("WEEK_NO"),
				WEEK_NO2,
				WEEK_NO2,				
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),
				WEEK_NO2,
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	
	
	
	
	/**
	 * 현재 년월 주차 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC020_SHR_WEEK(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/

		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC020_SHR_WEEK");

		//System.out.print(">>>>>>>>>>>>>>>>>>  PIS_YMD = " +p_box.get("PIS_YMD"));

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YMD"),
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);		
		
		
		
	}	
	
	
	
	
    /**
     * 주간업무보고 정보를 저장하는 DAO 메소드.
     * @param vo
     * @param p_box
     * @throws CException
	 */
	public void IDTC020_INS(GauceValueObject vo, CBox p_box) throws CException {
		
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("idt", "IDTC020_INS");


        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		JSPUtil.rns(vo.get("ENO_NO"))
               ,JSPUtil.rns(vo.get("WORK_WEEK"))
               ,JSPUtil.rns(vo.get("WORK_DETAIL1"))
               ,JSPUtil.rns(vo.get("WORK_DETAIL2"))
               ,JSPUtil.rns(vo.get("WORK_DETAIL3"))               
               ,JSPUtil.rns(vo.get("FEED_BACK"))
               ,JSPUtil.rns(vo.get("PLAN_EXE"))               
               ,JSPUtil.rns(vo.get("WEEK_NO"))
               ,JSPUtil.rns(p_box.get("vusrid"))         		//사원번호
               ,JSPUtil.rns(p_box.get("vusrid"))         		//사원번호
        };

        this.insertProcess(sql, bind);
        
	}
	
	
	
    /**
     * 주간업무보고 정보를 Update하는 DAO 메소드.
     * @param vo
     * @param p_box
     * @throws CException
	 */
	public void IDTC020_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("idt", "IDTC020_UPT");


        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		JSPUtil.rns(vo.get("WORK_DETAIL1"))
               ,JSPUtil.rns(vo.get("WORK_DETAIL2"))
               ,JSPUtil.rns(vo.get("WORK_DETAIL3"))               
               ,JSPUtil.rns(p_box.get("vusrid"))         		         
               ,JSPUtil.rns(vo.get("ENO_NO"))               
               ,JSPUtil.rns(vo.get("WEEK_NO"))
               ,JSPUtil.rns(vo.get("PLAN_EXE"))         		
        };

        this.insertProcess(sql, bind);
        
	}	
	

    /**
     * 내역을 삭제하는 DAO 메소드.
     * @param p_box
     * @throws CException
     */
	public void IDTC020_DEL(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("idt", "IDTC020_DEL");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
                	JSPUtil.rns(p_box.get("ENO_NO"))
	               ,JSPUtil.rns(p_box.get("WEEK_NO"))
	               
	    };

	    this.deleteProcess(sql, bind);
	}

}




