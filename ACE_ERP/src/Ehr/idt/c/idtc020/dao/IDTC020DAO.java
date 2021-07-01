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
	 * IDTC020DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTC020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	
	/**
	 * �ְ��������� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC020_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC020_SHR");

		int WEEK_NO2 = Integer.parseInt(p_box.get("WEEK_NO")) + 1 ;	
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
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
	 * ���� ��� ���� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC020_SHR_WEEK(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/

		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC020_SHR_WEEK");

		//System.out.print(">>>>>>>>>>>>>>>>>>  PIS_YMD = " +p_box.get("PIS_YMD"));

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YMD"),
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);		
		
		
		
	}	
	
	
	
	
    /**
     * �ְ��������� ������ �����ϴ� DAO �޼ҵ�.
     * @param vo
     * @param p_box
     * @throws CException
	 */
	public void IDTC020_INS(GauceValueObject vo, CBox p_box) throws CException {
		
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("idt", "IDTC020_INS");


        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		JSPUtil.rns(vo.get("ENO_NO"))
               ,JSPUtil.rns(vo.get("WORK_WEEK"))
               ,JSPUtil.rns(vo.get("WORK_DETAIL1"))
               ,JSPUtil.rns(vo.get("WORK_DETAIL2"))
               ,JSPUtil.rns(vo.get("WORK_DETAIL3"))               
               ,JSPUtil.rns(vo.get("FEED_BACK"))
               ,JSPUtil.rns(vo.get("PLAN_EXE"))               
               ,JSPUtil.rns(vo.get("WEEK_NO"))
               ,JSPUtil.rns(p_box.get("vusrid"))         		//�����ȣ
               ,JSPUtil.rns(p_box.get("vusrid"))         		//�����ȣ
        };

        this.insertProcess(sql, bind);
        
	}
	
	
	
    /**
     * �ְ��������� ������ Update�ϴ� DAO �޼ҵ�.
     * @param vo
     * @param p_box
     * @throws CException
	 */
	public void IDTC020_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
        /** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("idt", "IDTC020_UPT");


        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
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
     * ������ �����ϴ� DAO �޼ҵ�.
     * @param p_box
     * @throws CException
     */
	public void IDTC020_DEL(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("idt", "IDTC020_DEL");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
                	JSPUtil.rns(p_box.get("ENO_NO"))
	               ,JSPUtil.rns(p_box.get("WEEK_NO"))
	               
	    };

	    this.deleteProcess(sql, bind);
	}

}




