			<div id="main">
				<div class="nav"><a href="{U_INDEX}">首页</a>&gt;<a href="{U_ADMIN}">超级面板</a>&gt;<a href="{U_ADMIN_INDEX}">超级面板导航</a>&gt;附件配置</div>
				{ERROR_BOX}
				<p>在这里您可以调整一些关于附件功能的配制</p>
				<form action="{S_ATTACH_ACTION}" method="post">
					<div class="title">一般配置</div>
					<div class="module bm-gray">
						<label>附件功能：</label>
						<p>这里是附件功能的总开关</p>
						<div><input type="radio" name="disable_mod" value="0" {DISABLE_MOD_NO} /> 开启</div>
						<div><input type="radio" name="disable_mod" value="1" {DISABLE_MOD_YES} /> 关闭</div>
					</div>
					<div class="module bm-gray">
						<label>文件存放目录：</label>
						<div id="upload-dir"><input type="text" maxlength="100" name="upload_dir" value="{UPLOAD_DIR}" /></div>
					</div>
					<div class="module bm-gray">
						<label>附件图标：</label>
						<p>显示在附件前面的图标，留空则不显示，注意：这个设定会覆盖附件小组中的设置</p>
						<div id="upload-img"><input type="text" maxlength="100" name="upload_img" value="{ATTACHMENT_IMG_PATH}" /></div>
					</div>
					<div class="module bm-gray">
						<label>帖子附件图标：</label>
						<p>当帖子中带有附件时，这个图标就会显示在帖子标题的前面，如果留空则不显示</p>
						<div id="topic-icon"><input type="text" maxlength="100" name="topic_icon" value="{TOPIC_ICON}" /></div>
					</div>
					<div class="module bm-gray">
						<label>附件显示：</label>
						<div id="display-order-desc"><input type="radio" name="display_order" value="0" {DISPLAY_ORDER_DESC} /> 从高带低</div>
						<div id="display-order-asc"><input type="radio" name="display_order" value="1" {DISPLAY_ORDER_ASC} /> 从低到高</div>
					</div>
					<div class="module bm-gray">
						<label>积分的名称：</label>
						<div id="download-cut-points"><input type="text" size="3" name="points_name" value="{POINTS_NAME}" /></div>
					</div>
					<div class="module bm-gray">
						<label>下载积分设置：</label>
						<p>为了防止恶意下载和减轻服务器负担，每次下载附件需要扣取一定的积分</p>
						<div id="download-cut-points"><input type="text" size="3" name="download_cut_points" value="{DOWNLOAD_CUT_POINTS}" /></div>
					</div>
					<div class="module bm-gray">
						<label>下载积分设置：</label>
						<p>为了提高上传者的积极性，当其他用户下载附件时，上传者会获得一定的积分</p>
						<div id="download-add-points"><input type="text" size="3" maxlength="3" name="download_add_points" value="{DOWNLOAD_ADD_POINTS}" /></div>
					</div>
					<div class="module bm-gray">
						<label>新窗口打开附件：</label>					
						<div><input type="radio" name="attachment_topic_review" value="1" {TOPIC_REVIEW_YES} /> 是</div>
						<div><input type="radio" name="attachment_topic_review" value="0" {TOPIC_REVIEW_NO} /> 否</div>
					</div>
					<div class="module bm-gray">
						<label>显示新的附件控制面板：</label>
						<div><input type="radio" name="show_apcp" value="1" {SHOW_APCP_YES} /> 是</div>
						<div><input type="radio" name="show_apcp" value="0" {SHOW_APCP_NO} /> 否</div>
					</div>
					<div class="title">附件的限制设置</div>
					<div class="module bm-gray">
						<label>单文件最高限制：</label>
						<p>用户上传的每个附件不能大于以下数值，0 为不限制，当然这功能也会受到PHP的限制，例如PHP中设置最大上传文件大小现在为2M，那么下面这个数值超过2M，本系统中的设置将会失效</p>
						<div max-filesize><input type="text" size="8" maxlength="15" name="max_filesize" value="{MAX_FILESIZE}" /> {S_FILESIZE}</div>
					</div>
					<div class="module bm-gray">
						<label>总文件最高限制：</label>
						<p>用户上传的全部附件大小加起来不能大于以下数值，0 为不限制</p>
						<div id="attachment-quota"><input type="text" size="8" maxlength="15" name="attachment_quota" value="{ATTACHMENT_QUOTA}" /> {S_FILESIZE_QUOTA}</div>
					</div>
					<div class="module bm-gray">
						<label>默认上传限制设定：</label>
						<p>这里你可以选择一个默认限制给新注册的用户和没有指定限制的用户。选项 “没有限制” 表示没有不设定限制，而使用上面的附件大小限制设定。</p>
						<div id="selete-default-upload-limit">{S_DEFAULT_UPLOAD_LIMIT}</div>
					</div>
					<div class="module bm-gray">
						<label>帖子附件数量限制：</label>
						<p>用户发表一个帖子中最多可以附带多少个附件</p>
						<div id="max-attachments"><input type="text" size="3" maxlength="3" name="max_attachments" value="{MAX_ATTACHMENTS}" /></div>
					</div>
					<div class="title">FTP设置</div>
<!-- BEGIN switch_ftp -->
					<div class="module bm-gray">
						<label>FTP上传：</label>
						<div><input type="radio" name="allow_ftp_upload" value="1" {FTP_UPLOAD_YES} /> 开启</div>
						<div><input type="radio" name="allow_ftp_upload" value="0" {FTP_UPLOAD_NO} /> 禁用</div>
					</div>
					<div class="module bm-gray">
						<label>服务器地址：</label>
						<p>不需要输入ftp://</p>
						<div id="ftp-server"><input type="text" maxlength="100" name="ftp_server" value="{FTP_SERVER}" /></div>
					</div>
					<div class="module bm-gray">
						<label>FTP附件目录：</label>
						<div id="ftp-path"><input type="text" maxlength="100" name="ftp_path" value="{FTP_PATH}" /></div>
					</div>
					<div class="module bm-gray">
						<label>下载目录：</label>
						<p>请输入完整的路径，例如 http://phpbb-wap.com/upload。多馀的斜线「/」将被移除。保持这个栏位空白的，如果你有路径外面的你的网站根目录。但是与这个栏位空白的你无法使用实体的下载方式。</p>
						<div id="download-path"><input type="text" maxlength="100" name="download_path" value="{DOWNLOAD_PATH}" /></div>
					</div>
					<div class="module bm-gray">
						<label>被动模式：</label>
						<div><input type="radio" name="ftp_pasv_mode" value="1" {FTP_PASV_MODE_YES} /> 是</div>
						<div><input type="radio" name="ftp_pasv_mode" value="0" {FTP_PASV_MODE_NO} /> 否</div>
					</div>
					<div class="module bm-gray">
						<label>FTP用户名：</label>
						<div id="ftp-user"><input type="text" maxlength="100" name="ftp_user" value="{FTP_USER}" /></div>
					</div>
					<div class="module bm-gray">
						<label>FTP密码：</label>
						<div id="ftp-pass"><input type="password" maxlength="20" name="ftp_pass" value="{FTP_PASS}" /></div>
					</div>
<!-- END switch_ftp -->
<!-- BEGIN switch_no_ftp -->
					<input type="hidden" name="allow_ftp_upload" value="0" />
					<div class="module">您的服务器不支持该功能</div>
<!-- END switch_no_ftp -->
					{S_HIDDEN_FIELDS}
					<div id="center">
						<input type="submit" name="submit" value="保存" />
						<input type="submit" name="settings" value="测试" />
					</div>
				</form>
			</div>