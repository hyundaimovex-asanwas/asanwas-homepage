package com.hmm.asan.asanway.admin;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.AsanFileRenamePolicy;
import com.hmm.asan.common.util.PagingHelper;
import com.hmm.asan.common.util.Utility;
import com.hmm.asan.common.util.WEBConstants;

import com.oreilly.servlet.MultipartRequest;


/**
 * ������ ���� ������ ����
 */
public class MainBean {
    /**
     * ���� ������ ����
     * @author : ikara
     * @2005. 11. 24
     */
    public void MainInfo(HttpServletRequest request, HttpServletResponse response) {
        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;
        try{
	        //��ü �Ϲ� ȸ��
	        String  totalMember =String.valueOf(mdao.getRowCount("select count(*) count from asan.member "));
	        request.setAttribute("totalMember", totalMember);

	        //���� ������ ȸ����
	        String  todayMember =String.valueOf(mdao.getRowCount("select count(*) count from asan.member where  date(regtime) = current date "));
	        request.setAttribute("todayMember", todayMember);

	        //���� ������ �޴� list
	       String  listQuery = " select category, count(*) cnt from asan.notice where date(regtime)=current date group by category" +
	        		" union all" +
	        		" select category, count(*) cnt from asan.press where date(regtime)=current date group by category" +
	        		" union all" +
	        		" select category, count(*) cnt from asan.letter where date(regtime)=current date group by category" +
	        		" union all" +
	        		" select category || 'mem', count(*) cnt from asan.lettermem where date(regtime)=current date group by category" +
	        		" union all" +
	        		" select category, count(*) cnt from asan.gallery where date(regtime)=current date group by category" +
	        		" union all" +
	        		" select category, count(*) cnt from asan.ceotrend where date(regtime)=current date group by category" +
	        		" union all" +
	        		" select 'linksite' category, count(*) cnt from asan.linksite where date(regtime) = current date" +
	        		" union all" +
	        		" select category, count(*) cnt from asan.event where date(regtime)=current date group by category" +
	        		" union all" +
	        		" select category, count(*) cnt from asan.scrap where date(regtime)=current date group by category" +
	        		" union all" +
	        		" select category, count(*) cnt from asan.qna where date(regtime)=current date group by category" +
	        		" union all" +
	        		" select 'poll' as category, count(*) cnt from asan.poll where date(regtime)=current date" ;
	        list = mdao.selectQuery(listQuery);
	        request.setAttribute("newmenulist", list);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * ���� ��� ���� ����Ʈ
     * @author : ikara
     * @2005. 11. 24
     */
    public void NoticeList(HttpServletRequest request, HttpServletResponse response, int count) {
        ArrayList list = null;
        MultiDAO mdao = new MultiDAO();

        try{
            String listQuery = "select idx, title,  regtime, hit, group, level, status from asan.adminbbs where category = 'adminnotice' and isdel = '0' ";
	        listQuery += " ORDER BY  group DESC, order ASC";
            listQuery += " FETCH FIRST " + count + " ROWS ONLY ";
            list = mdao.selectQuery(listQuery);
            request.setAttribute("noticelist", list);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * ���� ��� Qna ����Ʈ
     * @author : ikara
     * @2005. 11. 24
     */
    public void QnaList(HttpServletRequest request, HttpServletResponse response, int count) {
        ArrayList list = null;
        MultiDAO mdao = new MultiDAO();

        try{
            String listQuery = "select idx, title, regtime, hit, group, level, status from asan.qna where category = 'qna' and isdel = '0' ";
	        listQuery += " ORDER BY  group DESC, level ASC";
            listQuery += " FETCH FIRST " + count + " ROWS ONLY ";
            list = mdao.selectQuery(listQuery);
	        request.setAttribute("qnalist", list);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}