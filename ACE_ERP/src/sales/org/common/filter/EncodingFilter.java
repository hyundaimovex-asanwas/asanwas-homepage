/*******************************************************************************
 * 1.Ŭ����   �� : EncodingFilter.java
 * 2.Ŭ���� ���� :
 * 3.���� ���̺� :
 * 4.���� Ŭ���� :
 * 5.���� ������ :
 * 6.��   ��  �� : ���¼�
 * 7.�� �� �� �� : 2004-03-30
 * 8.�� �� �� �� :
 * . <��¥>       ; <���� ����> (<�����ڸ�>)
 * . 2004-03-24      ;
 * @author ���¼�
 * @version 1.0 2006-02-02
 ******************************************************************************/

package sales.org.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * <pre>
 * Servlet 2.3 �̻��� ��� web.xml ���Ͽ� EncodingFilter Ŭ������
 * ����ϸ� ServletRequest ��ü�� ���޵Ǵ� ���� �⺻ ���ڵ�����
 * ������ �� �ִ�.
 * web.xml ���� ����� ������ ����.
 * &lt;filter&gt;
 *  &lt;filter-name&gt;Encoding Filter&lt;/filter-name&gt;
 *     &lt;display-name&gt;Encoding Filter&lt;/display-name&gt;
 *     &lt;filter-class&gt;com.ktf.cass.util.EncodingFilter&lt;/filter-class&gt;
 *     &lt;init-param&gt;
 *        &lt;param-name&gt;encoding&lt;/param-name&gt;
 *        &lt;param-value&gt;EUC-KR&lt;/param-value&gt;
 *     &lt;/init-param&gt;
 *  &lt;/filter&gt;

 *  &lt;filter-mapping&gt;
 *     &lt;filter-name&gt;Encoding Filter&lt;/filter-name&gt;
 *     &lt;url-pattern&gt;/*&lt;/url-pattern&gt;
 *  &lt;/filter-mapping&gt;
 *   
 * </pre>
 */
public class EncodingFilter implements Filter {
	
	private String encoding = null;
	
	/**
	 * ���� ���� ��ü�� ��Ÿ����.
	 */
	protected FilterConfig filterConfig = null;
	
	/**
	 * EncodingFilter ��ü�� �Ҹ��Ű��, ���������� �ʱ�ȭ �Ѵ�.	 
	 * @return void
	 */
	public void destroy() {

		this.encoding = null;
		this.filterConfig = null;

	}
	/**
	 * ServletRequest��ü�� web.xml���� ���޵� ���ڵ��� �����Ѵ�.
	 * @param request ���񽺸� ��û�ϴ� ��ü.
	 * @param response ��û�� ���ϴ� ��ü. 
	 * @param chain ���ڵ��� �ϴ� ��ü.
	 * @return void
	 */
	public void doFilter(
		ServletRequest request,
		ServletResponse response,
		FilterChain chain)
		throws IOException, ServletException {

		if (request.getCharacterEncoding() == null) {
			if (encoding != null) {
				request.setCharacterEncoding(encoding);
			}
		}
		chain.doFilter(request, response);
		
	}

	/**
	 * web.xml���� ���޵� ���ڵ� ���� �ʱ�ȭ�Ѵ�.
	 * @param filterConfig ���ڵ� �ʱ�ȭ ������ ������ �ִ� ��ü.
	 * @return void
	 */
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		this.encoding = filterConfig.getInitParameter("encoding");
	}
	/**
	 * ���� ������ ���� ȯ�氪�� �����´�.
	 * @return FilterConfig 
	 */
	public FilterConfig getFilterConfig() {
		return filterConfig;
	}
	/**
	 * ���� ȯ���� �����Ѵ�.
	 * @param cfg ���ڵ��� ���� ������ ������ �ִ� ��ü.
	 * @return void
	 */
	public void setFilterConfig(FilterConfig cfg) {
		filterConfig = cfg;
	}
}
