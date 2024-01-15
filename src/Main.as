bool isShadowsDisabled = false;
bool isShadowsDisabledOld = true;
bool inReplayEditorOld = false;
bool isInMapOld = false;
CTrackMania@ g_app;
CGameCtnChallenge@ GetCurrentMap()
{
#if MP41 || TMNEXT
	return g_app.RootMap;
#else
	return g_app.Challenge;
#endif
}

void Main() {
    @g_app = cast<CTrackMania>(GetApp());

    while(true){
        bool inReplayEditorEditing =  @g_app.Editor !is null &&  @g_app.PlaygroundScript is null;
        bool inReplayEditorViewing =  @g_app.Editor !is null &&  @g_app.CurrentPlayground is null &&  @g_app.RootMap !is null;
        bool inReplayEditor = inReplayEditorEditing || inReplayEditorViewing;
        if(!inReplayEditor) isShadowsDisabled = false;

        int textureRender = (isShadowsDisabled ? 1 : 2);

		CHmsViewport@ viewport = cast<CHmsViewport>(@g_app.Viewport);
        if(viewport != null && viewport.TextureRender != textureRender) {
            viewport.TextureRender =  textureRender;
        }
        yield();
    }
}

void RenderMenu()
{
	bool inReplayEditorEditing =  @g_app.Editor !is null &&  @g_app.PlaygroundScript is null;
	bool inReplayEditorViewing =  @g_app.Editor !is null &&  @g_app.CurrentPlayground is null &&  @g_app.RootMap !is null;
	bool inReplayEditor = inReplayEditorEditing || inReplayEditorViewing;

	auto map = @g_app.RootMap;
	if (map !is null && inReplayEditor) {
		if(UI::MenuItem(Icons::Sun + " Disable shadows", "", isShadowsDisabled)) {
			isShadowsDisabled = !isShadowsDisabled;
		}
	}
}