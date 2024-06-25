cmake_minimum_required (VERSION 3.19)
project(Editors)

### LevelEditor

file(GLOB_RECURSE leveleditor_sources
    BoxCreator.cpp
    DirectoryHandler.cpp
    EditorAction.cpp
    EditorActionArea.cpp
    EditorActionCompoundObject.cpp
    EditorActionDynamicEntity.cpp
    EditorActionEntity.cpp
    EditorActionHandler.cpp
    EditorActionMisc.cpp
    EditorActionSelection.cpp
    EditorAxisAlignedPlane.cpp
    EditorBaseClasses.cpp
    EditorClipPlane.cpp
    EditorEditMode.cpp
    EditorEditModeAreas.cpp
    EditorEditModeBillboards.cpp
    EditorEditModeCombine.cpp
    EditorEditModeDecals.cpp
    EditorEditModeEntities.cpp
    EditorEditModeFogAreas.cpp
    EditorEditModeLights.cpp
    EditorEditModeParticleSystems.cpp
    EditorEditModePrimitive.cpp
    EditorEditModeSelect.cpp
    EditorEditModeSelectTool.cpp
    EditorEditModeSelectToolRotate.cpp
    EditorEditModeSelectToolScale.cpp
    EditorEditModeSelectToolTranslate.cpp
    EditorEditModeSounds.cpp
    EditorEditModeStaticObjects.cpp
    EditorGrid.cpp
    EditorHelper.cpp
    EditorIndex.cpp
    EditorInput.cpp
    EditorSelection.cpp
    EditorThumbnailBuilder.cpp
    EditorUserClassDefinitionManager.cpp
    EditorVar.cpp
    EditorViewport.cpp
    EditorWindow.cpp
    EditorWindowAreas.cpp
    EditorWindowBillboards.cpp
    EditorWindowCombine.cpp
    EditorWindowDecals.cpp
    EditorWindowEditModeSidebar.cpp
    EditorWindowEntities.cpp
    EditorWindowEntityEditBox.cpp
    EditorWindowEntityEditBoxArea.cpp
    EditorWindowEntityEditBoxBillboard.cpp
    EditorWindowEntityEditBoxCompound.cpp
    EditorWindowEntityEditBoxDecal.cpp
    EditorWindowEntityEditBoxEntity.cpp
    EditorWindowEntityEditBoxFogArea.cpp
    EditorWindowEntityEditBoxGroup.cpp
    EditorWindowEntityEditBoxLight.cpp
    EditorWindowEntityEditBoxParticleSystem.cpp
    EditorWindowEntityEditBoxPrimitive.cpp
    EditorWindowEntityEditBoxSound.cpp
    EditorWindowEntityEditBoxStaticObject.cpp
    EditorWindowEntitySearch.cpp
    EditorWindowFactory.cpp
    EditorWindowFogAreas.cpp
    EditorWindowLights.cpp
    EditorWindowLoaderStatus.cpp
    EditorWindowLowerToolbar.cpp
    EditorWindowMaterialEditor.cpp
    EditorWindowObjectBrowser.cpp
    EditorWindowOptions.cpp
    EditorWindowParticleSystems.cpp
    EditorWindowPrimitives.cpp
    EditorWindowSelect.cpp
    EditorWindowSoundBrowser.cpp
    EditorWindowSounds.cpp
    EditorWindowStaticObjects.cpp
    EditorWindowTextureBrowser.cpp
    EditorWindowViewport.cpp
    EditorWorld.cpp
    EngineEntity.cpp
    EntityIcon.cpp
    EntityPicker.cpp
    EntityWrapper.cpp
    EntityWrapperArea.cpp
    EntityWrapperBillboard.cpp
    EntityWrapperCompoundObject.cpp
    EntityWrapperDecal.cpp
    EntityWrapperEntity.cpp
    EntityWrapperFogArea.cpp
    EntityWrapperLight.cpp
    EntityWrapperLightBox.cpp
    EntityWrapperLightPoint.cpp
    EntityWrapperLightSpot.cpp
    EntityWrapperParticleSystem.cpp
    EntityWrapperPrimitive.cpp
    EntityWrapperPrimitivePlane.cpp
    EntityWrapperSound.cpp
    EntityWrapperStaticObject.cpp
    SphereCreator.cpp
    StdAfx.cpp
    SurfacePicker.cpp

    LevelEditor.cpp
    LevelEditorActions.cpp
    LevelEditorMain.cpp
    LevelEditorStaticObjectCombo.cpp
    LevelEditorWindow.cpp
    LevelEditorWindowGroup.cpp
    LevelEditorWindowLevelSettings.cpp
    LevelEditorWindowAbout.cpp
    LevelEditorWorld.cpp
    )

if(WIN32)
    # Level Editor Icon
    list(APPEND leveleditor_sources "leveleditor/LevelEditor.rc")
endif()

AddToolTarget(LevelEditorCE
    ${leveleditor_sources}
)

### ModelEditor

file(GLOB_RECURSE modeleditor_sources
	BoxCreator.cpp
	DirectoryHandler.cpp
    EditorAction.cpp
    EditorActionCompoundObject.cpp
    EditorActionEntity.cpp
    EditorActionHandler.cpp
    EditorActionMisc.cpp
    EditorActionSelection.cpp
    EditorActionsBodies.cpp
    EditorActionsSubMesh.cpp
    EditorAxisAlignedPlane.cpp
    EditorBaseClasses.cpp
    EditorClipPlane.cpp
    EditorEditMode.cpp
    EditorEditModeBillboards.cpp
    EditorEditModeBodies.cpp
    EditorEditModeJoints.cpp
    EditorEditModeLights.cpp
    EditorEditModeParticleSystems.cpp
    EditorEditModeSelect.cpp
    EditorEditModeSelectTool.cpp
    EditorEditModeSelectToolRotate.cpp
    EditorEditModeSelectToolScale.cpp
    EditorEditModeSelectToolTranslate.cpp
    EditorEditModeSounds.cpp
    EditorGrid.cpp
    EditorHelper.cpp
    EditorIndex.cpp
    EditorInput.cpp
    EditorSelection.cpp
    EditorThumbnailBuilder.cpp
    EditorUserClassDefinitionManager.cpp
    EditorVar.cpp
    EditorViewport.cpp
    EditorWindow.cpp
    EditorWindowBillboards.cpp
    EditorWindowBodies.cpp
    EditorWindowEditModeSidebar.cpp
    EditorWindowEntities.cpp
    EditorWindowEntityEditBox.cpp
    EditorWindowEntityEditBoxBillboard.cpp
    EditorWindowEntityEditBoxBody.cpp
    EditorWindowEntityEditBoxBodyShape.cpp
    EditorWindowEntityEditBoxBone.cpp
    EditorWindowEntityEditBoxCompound.cpp
    EditorWindowEntityEditBoxGroup.cpp
    EditorWindowEntityEditBoxGroupShapes.cpp
    EditorWindowEntityEditBoxJoint.cpp
    EditorWindowEntityEditBoxLight.cpp
    EditorWindowEntityEditBoxParticleSystem.cpp
    EditorWindowEntityEditBoxSound.cpp
    EditorWindowEntityEditBoxSubMesh.cpp
    EditorWindowEntitySearch.cpp
    EditorWindowFactory.cpp
    EditorWindowJoints.cpp
    EditorWindowLights.cpp
    EditorWindowLoaderStatus.cpp
    EditorWindowLowerToolbar.cpp
    EditorWindowMaterialEditor.cpp
    EditorWindowObjectBrowser.cpp
    EditorWindowOptions.cpp
    EditorWindowParticleSystems.cpp
    EditorWindowSelect.cpp
    EditorWindowSoundBrowser.cpp
    EditorWindowSounds.cpp
    EditorWindowTextureBrowser.cpp
    EditorWindowViewport.cpp
    EditorWorld.cpp
    EngineEntity.cpp
    EntityIcon.cpp
    EntityPicker.cpp
    EntityWrapper.cpp
    EntityWrapperBillboard.cpp
    EntityWrapperBody.cpp
    EntityWrapperBodyShape.cpp
    EntityWrapperBone.cpp
    EntityWrapperCompoundObject.cpp
    EntityWrapperJoint.cpp
    EntityWrapperJointBall.cpp
    EntityWrapperJointHinge.cpp
    EntityWrapperJointScrew.cpp
    EntityWrapperJointSlider.cpp
    EntityWrapperLight.cpp
    EntityWrapperLightBox.cpp
    EntityWrapperLightPoint.cpp
    EntityWrapperLightSpot.cpp
    EntityWrapperParticleSystem.cpp
    EntityWrapperSound.cpp
    EntityWrapperSubMesh.cpp
    SphereCreator.cpp
    StdAfx.cpp
    SurfacePicker.cpp


    ModelEditor.cpp
    ModelEditorActions.cpp
    ModelEditorLowerToolbar.cpp
    ModelEditorMain.cpp
    ModelEditorWindowAnimations.cpp
    ModelEditorWindowOutline.cpp
    ModelEditorWindowPhysicsTest.cpp
    ModelEditorWindowUserSettings.cpp
    ModelEditorWorld.cpp
)

if(WIN32)
    # Model Editor Icon
    list(APPEND modeleditor_sources "modeleditor/ModelEditor.rc")
endif()

AddToolTarget(ModelEditorCE
    ${modeleditor_sources}
)

### ParticleEditor

file(GLOB_RECURSE particleeditor_sources
    DirectoryHandler.cpp
    EditorAction.cpp
    EditorActionCompoundObject.cpp
    EditorActionEntity.cpp
    EditorActionHandler.cpp
    EditorActionMisc.cpp
    EditorActionSelection.cpp
    EditorAxisAlignedPlane.cpp
    EditorBaseClasses.cpp
    EditorClipPlane.cpp
    EditorEditMode.cpp
    EditorEditModeSelect.cpp
    EditorEditModeSelectTool.cpp
    EditorEditModeSelectToolRotate.cpp
    EditorEditModeSelectToolScale.cpp
    EditorEditModeSelectToolTranslate.cpp
    EditorGrid.cpp
    EditorHelper.cpp
    EditorIndex.cpp
    EditorInput.cpp
    EditorSelection.cpp
    EditorThumbnailBuilder.cpp
    EditorUserClassDefinitionManager.cpp
    EditorVar.cpp
    EditorViewport.cpp
    EditorWindow.cpp
    EditorWindowEditModeSidebar.cpp
    EditorWindowEntityEditBox.cpp
    EditorWindowEntityEditBoxCompound.cpp
    EditorWindowEntityEditBoxGroup.cpp
    EditorWindowEntitySearch.cpp
    EditorWindowFactory.cpp
    EditorWindowLoaderStatus.cpp
    EditorWindowLowerToolbar.cpp
    EditorWindowMaterialEditor.cpp
    EditorWindowOptions.cpp
    EditorWindowSelect.cpp
    EditorWindowSoundBrowser.cpp
    EditorWindowTextureBrowser.cpp
    EditorWindowViewport.cpp
    EditorWorld.cpp
    EngineEntity.cpp
    EntityIcon.cpp
    EntityPicker.cpp
    EntityWrapper.cpp
    EntityWrapperCompoundObject.cpp
    StdAfx.cpp
    SurfacePicker.cpp

    EntityWrapperParticleEmitter.cpp
    ParticleEditor.cpp
    ParticleEditorActions.cpp
    ParticleEditorMain.cpp
    ParticleEditorWindowEmitterParams.cpp
    ParticleEditorWindowEmitters.cpp
    ParticleEditorWorld.cpp
)

if(WIN32)
    # Particle Editor Icon
    list(APPEND particleeditor_sources "particleeditor/ParticleEditor.rc")
endif()

AddToolTarget(ParticleEditorCE
    ${particleeditor_sources}
)

### MaterialEditor

file(GLOB_RECURSE materialeditor_sources
    DirectoryHandler.cpp
    EditorAction.cpp
    EditorActionCompoundObject.cpp
    EditorActionEntity.cpp
    EditorActionHandler.cpp
    EditorActionMisc.cpp
    EditorActionSelection.cpp
    EditorAxisAlignedPlane.cpp
    EditorBaseClasses.cpp
    EditorClipPlane.cpp
    EditorEditMode.cpp
    EditorEditModeSelect.cpp
    EditorEditModeSelectTool.cpp
    EditorEditModeSelectToolRotate.cpp
    EditorEditModeSelectToolScale.cpp
    EditorEditModeSelectToolTranslate.cpp
    EditorGrid.cpp
    EditorHelper.cpp
    EditorIndex.cpp
    EditorInput.cpp
    EditorSelection.cpp
    EditorThumbnailBuilder.cpp
    EditorUserClassDefinitionManager.cpp
    EditorVar.cpp
    EditorViewport.cpp
    EditorWindow.cpp
    EditorWindowEditModeSidebar.cpp
    EditorWindowEntityEditBox.cpp
    EditorWindowEntityEditBoxCompound.cpp
    EditorWindowEntityEditBoxGroup.cpp
    EditorWindowEntitySearch.cpp
    EditorWindowFactory.cpp
    EditorWindowLoaderStatus.cpp
    EditorWindowLowerToolbar.cpp
    EditorWindowMaterialEditor.cpp
    EditorWindowOptions.cpp
    EditorWindowSelect.cpp
    EditorWindowSoundBrowser.cpp
    EditorWindowTextureBrowser.cpp
    EditorWindowViewport.cpp
    EditorWorld.cpp
    EngineEntity.cpp
    EntityIcon.cpp
    EntityPicker.cpp
    EntityWrapper.cpp
    EntityWrapperCompoundObject.cpp
    StdAfx.cpp
    SurfacePicker.cpp

    MaterialEditor.cpp
    MaterialEditorMain.cpp
)

if(WIN32)
    # Material Editor Icon
    list(APPEND materialeditor_sources "materialeditor/MaterialEditor.rc")
endif()

AddToolTarget(MaterialEditorCE
    ${materialeditor_sources}
)

