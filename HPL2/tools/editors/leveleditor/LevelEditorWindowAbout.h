
#ifndef HPLEDITOR_EDITOR_ABOUT_H
#define HPLEDITOR_EDITOR_ABOUT_H

#include "../common/EditorWindow.h"

class cLevelEditorWindowAbout : public iEditorWindowPopUp
{
public:
	cLevelEditorWindowAbout(iEditorBase* apEditor);
	~cLevelEditorWindowAbout();

	bool WebsiteCallback(iWidget* apWidget, const cGuiMessageData& aData);
	kGuiCallbackDeclarationEnd(WebsiteCallback);

protected:
	void OnInitLayout();
	void OnSetActive(bool abX);

	bool WindowSpecificInputCallback(iEditorInput* apInput);

    cWidgetLabel* mpLabelTitle;
    cWidgetLabel* mpLabelVersion;
	cWidgetLabel* mpLabelDescription;

    cWidgetButton* mpButtonGithub;
};

#endif //HPLEDITOR_EDITOR_ABOUT_H 