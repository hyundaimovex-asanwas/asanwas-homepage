package Ehr.cdp.a.book011.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BOOK011DAO extends AbstractDAO {

	/**
	 * BOOK011DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BOOK011DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * ���缱 ����
     * @param p_box
     * @throws CException
     */
	public void BOOK011_UPT_APP(CBox p_box) throws CException {


	    /** �ܺ� XML���� SQL�� �о� �´� * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK011_UPT_APP");
	    String seq_no = JSPUtil.rns(p_box.get("SEQ_NO"));

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
	    Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("APP_YN" ))
                ,p_box.get("vusrid")
	            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	            ,JSPUtil.rns(p_box.get("GUN_GBN"))
	            ,JSPUtil.rns(p_box.get("GUN_DPT"))
	            ,JSPUtil.rns(p_box.get("SEQ_NO" ))
	    };

	    /** INSERT�޼ҵ� ȣ�� * */
	    updateProcess(sql, bind);


	    if(seq_no.equals("1")){

		    sql = XmlSqlUtils.getSQL("gun", "BOOK011_UPT_APP");

		    /** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
		    bind = new Object[] {
	                 "R"
	                ,p_box.get("vusrid")
		            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
		            ,JSPUtil.rns(p_box.get("GUN_GBN"))
		            ,JSPUtil.rns(p_box.get("GUN_DPT"))
		            ,"2"
		    };
		    /** INSERT�޼ҵ� ȣ�� * */
		    updateProcess(sql, bind);
	    }

	}



	/**
	 * �������Խ�û Detail ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BOOK011_UPT_DETAIL(CBox p_box, GauceValueObject vo) throws CException {


		System.out.print(p_box);
		System.out.print(vo);

	    /** �ܺ� XML���� SQL�� �о� �´� * */
	    String sql = XmlSqlUtils.getSQL("cdp", "BOOK011_UPT_DETAIL");

		Object[] sqlParam = new Object[] {

		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
	    Object[] bind = new Object[]{

		        JSPUtil.rns(vo.get("BOOK_NM" ))
		        ,JSPUtil.rns(vo.get("BOOK_PUL" ))
		        ,JSPUtil.rns(vo.get("BOOK_WRT" ))
		        ,JSPUtil.rns(vo.get("BOOK_QTY" ))
		        ,JSPUtil.rns(vo.get("BOOK_AMT" ))
		        ,JSPUtil.rns(vo.get("BOOK_REMARK" ))
				,p_box.get("vusrid")
				,p_box.get("REQ_NO")
		        ,JSPUtil.rns(vo.get("RQST_SEQ" ))
			};

	    /** INSERT�޼ҵ� ȣ�� * */
	    updateProcess(sql, bind);


	}




	public void BOOK011_UPT_HOL(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK011_UPT_HOL");
	    String seq_no = JSPUtil.rns(p_box.get("SEQ_NO"));
	    String app_yn = JSPUtil.rns(p_box.get("APP_YN" ));
	    String gun_gbn = JSPUtil.rns(p_box.get("GUN_GBN"));

		StringBuffer sb = new StringBuffer();

	    if (gun_gbn.equals("R")) {
	    	sb.append("END_TAG");
	    } else if (gun_gbn.equals("H")) {
	    	sb.append("SIGN_TAG");
	    } else if (gun_gbn.equals("J")) {
	    	sb.append("CONF_TAG");
	    }

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
	    Object[] bind = new Object[]{
		    	seq_no
		    	,app_yn
		    	,app_yn
	            ,p_box.get("vusrid")
	            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	            ,JSPUtil.rns(p_box.get("GUN_DPT"))
			};

	    /** INSERT�޼ҵ� ȣ�� * */
	    updateProcess(sql, bind);
	}





	public void BOOK011_UPT_REJ(CBox p_box) throws CException {


	    /** �ܺ� XML���� SQL�� �о� �´� * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK011_UPT_REJ");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
	    Object[] bind = new Object[] {
	             JSPUtil.rns(p_box.get("APP_YN" ))
	            ,p_box.get("vusrid")
	            ,JSPUtil.rns(p_box.get("REMARK"))
	            ,JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", "")
	            ,JSPUtil.rns(p_box.get("GUN_GBN"))
	            ,JSPUtil.rns(p_box.get("GUN_DPT"))
	            ,JSPUtil.rns(p_box.get("SEQ_NO" ))
	    };

	    /** INSERT�޼ҵ� ȣ�� * */
	    updateProcess(sql, bind);
	}




	/**
	 * ���� ó�������� �ݿ�(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BOOK011_UPT(CBox p_box, GauceValueObject vo) throws CException {

		System.out.print(p_box);
		System.out.print(vo);


		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK011_UPT_NEW");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("APP_YN"),
				JSPUtil.rns(vo.get("REMARK")),				//��� -> �ʵ�����  Container ����t("REMARK"),
				p_box.get("vusrid"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("vusrid")
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}





	/**
	 * ���� ��Ϲ�ȣ�� �����Ѱ�������(����)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet BOOK011_CNT(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cdp", "BOOK011_CNT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش�  **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN")
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		return selectProcess(sql, bind);
	}






	public void BOOK011_UPT_HOL_NEW(CBox p_box, String APP_YN ) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� * */
	    String sql = XmlSqlUtils.getSQL("cdp", "BOOK011_UPT_HOL_NEW");


	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
	    Object[] bind = new Object[]{
	    		 APP_YN
	            ,p_box.get("vusrid")
				,p_box.get("REQ_NO")
			};


	    /** INSERT�޼ҵ� ȣ�� * */
	    updateProcess(sql, bind);

	}





	public void BOOK011_UPT_HOL_NEW_H(CBox p_box, String APP_YN ) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� * */
	    String sql = XmlSqlUtils.getSQL("gun", "BOOK011_UPT_HOL_NEW_H");

	    String gun_gbn = JSPUtil.rns(p_box.get("GUN_GBN"));

		StringBuffer sb = new StringBuffer();

	    if (gun_gbn.equals("R")) {
	    	sb.append("END_TAG");
	    } else if (gun_gbn.equals("H")) {
	    	sb.append("SIGN_TAG");
	    } else if (gun_gbn.equals("J")) {
	    	sb.append("CONF_TAG");
	    }

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� * */
	    Object[] bind = new Object[]{
	    		 APP_YN
	            ,p_box.get("vusrid")
	            ,p_box.get("GUN_YMD").replaceAll("-", "")
	            ,p_box.get("GUN_DPT")
			};

	    /** INSERT�޼ҵ� ȣ�� * */
	    updateProcess(sql, bind);
	}
}