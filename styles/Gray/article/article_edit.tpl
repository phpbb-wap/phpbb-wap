			<div id="main">
				<div class="title">{L_TITLE}</div>
				{ERROR_BOX}
				<form action="{S_ACTION}" method="post">
					<div class="module row1">
						标题：<br />
						{ARTICLE_CLASS}
<!-- BEGIN admin -->
						(<a href="{admin.CLASS_CREATE}">添加</a>/<a href="{admin.CLASS_MANAGE}">管理</a>)
<!-- END admin -->
						<input type="text" name="title" value="{ARTICLE_TITLE}" maxlength="64" />
					</div>
					<div class="module row2">
						内容：<br />
						<textarea name="text" rows="5" style="width:100%;">{ARTICLE_TEXT}</textarea>
					</div>
					<input type="submit" name="submit" value="保存" />
				</form>
				<div class="nav"><a href="{U_BACK}">返回上级</a> / <a href="{U_INDEX}">返回首页</a></div>
			</div>