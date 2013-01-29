<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="wpfssa" uri="/WEB-INF/plugins/jpfrontshortcut/apsadmin/tld/jpfrontshortcut-apsadmin-core.tld" %>

<%--
<wp:headInfo type="JS" info="../../plugins/jpfastcontentedit/static/js/moo-japs/moo-jAPS-0.2.js" />

<s:set name="js_for_tab">

//per categorie
window.addEvent('domready', function(){
	var catTree  = new Wood({
		menuToggler: "subTreeToggler",
		rootId: "categoryTree",
		openClass: "node_open",
		closedClass: "node_closed",
		showTools: "true",
		expandAllLabel: "<s:text name="label.expandAll" />",
		collapseAllLabel: "<s:text name="label.collapseAll" />",
		type: "tree",
		<s:if test="%{selectedNode != null && !(selectedNode.equalsIgnoreCase(''))}">
		startIndex: "fagianonode_<s:property value="selectedNode" />",
		</s:if>
		toolTextIntro: "<s:text name="label.introExpandAll" />",
		toolexpandAllLabelTitle: "<s:text name="label.expandAllTitle" />",
		toolcollapseLabelTitle: "<s:text name="label.collapseAllTitle" />"
	});

});

</s:set>
<wp:headInfo type="JS_RAW" info="${js_for_tab}" />
--%>
<wp:i18n key="jpfastcontentedit_FASTCONTENTEDIT_SHOWLET_TITLE" />
<br />

<h3><wp:i18n key="jpfastcontentedit_CHOOSE_IMAGE" /></h3>

<s:form id="formform" action="search" namespace="/do/jpfrontshortcut/Content/Resource" theme="simple">

<fieldset><legend><wp:i18n key="jpfastcontentedit_SEARCH_FILTERS" /></legend>
<p class="noscreen"><wpsf:hidden name="resourceTypeCode" /></p>
<p>
	<label for="text"><wp:i18n key="jpfastcontentedit_DESCRIPTION" />:</label><br />
	<wpsf:textfield useTabindexAutoIncrement="true" name="text" id="text" cssClass="text" />
</p>

<p>
	<wp:i18n key="jpfastcontentedit_CATEGORY" />:<br />
</p>

<ul id="categoryTree">
	<s:set name="inputFieldName" value="'categoryCode'" />
	<s:set name="selectedTreeNode" value="selectedNode" />
	<s:set name="liClassName" value="'category'" />
	<s:set name="currentRoot" value="categoryRoot" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder.jsp" />
</ul>

</fieldset>

<p>
	<s:set name="search_label"><wp:i18n key="jpfastcontentedit_SEARCH" /></s:set>
	<s:url var="executeSearchUrlVar" namespace="/do/jpfrontshortcut/Content/Resource" action="search" />
	<sj:submit targets="form-container" indicator="indicator" href="%{#executeSearchUrlVar}" 
			   value="%{#search_label}" button="true" />
</p>

<wpfssa:subset source="resources" count="10" objectName="groupResource" advanced="true" offset="5">
<s:set name="group" value="#groupResource" />
<s:set var="pagerSubmitActionNameVar" value="'search'" />

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/plugins/jpfrontshortcut/aps/jsp/internalservlet/include/pager_formBlock.jsp" />
</div>

<s:iterator id="resourceid">
<s:set name="resource" value="%{loadResource(#resourceid)}"></s:set>
<%-- http://www.maxdesign.com.au/presentation/definition/dl-image-gallery.htm --%>
<dl class="gallery">
	<dt class="image"><a href="<s:property value="%{#resource.getImagePath(0)}" />" ><img src="<s:property value="%{#resource.getImagePath(1)}"/>" alt=" " /></a></dt>
	<dt class="options">
		<wpfssa:actionParam action="joinResource" var="joinResourceActionNameVar" >
			<wpfssa:actionSubParam name="resourceId" value="%{#resourceid}" />
		</wpfssa:actionParam>
		<s:url var="joinResourceActionVar" action="%{#joinResourceActionNameVar}" />
		<sj:submit targets="form-container" value="%{getText('label.join')}" 
				   button="true" href="%{#joinResourceActionVar}" />
	</dt>
	<dd>
		<p><s:property value="#resource.descr" /></p>
	</dd>
</dl>

</s:iterator>

<div class="pager clear">
	<s:include value="/WEB-INF/plugins/jpfrontshortcut/aps/jsp/internalservlet/include/pager_formBlock.jsp" />
</div>

</wpfssa:subset>

</s:form>