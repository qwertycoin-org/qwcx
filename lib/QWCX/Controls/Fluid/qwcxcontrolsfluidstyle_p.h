#ifndef QWCX_CONTROLS_FLUID_QWCXCONTROLSFLUIDSTYLE_P_H
#define QWCX_CONTROLS_FLUID_QWCXCONTROLSFLUIDSTYLE_P_H

#include <QtGui/QColor>
#include <QtGui/QFont>
#include <QtQuickControls2/private/qquickattachedobject_p.h>
#include <QWCX/Global/constants.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

class QwcxControlsFluidStyle : public QQuickAttachedObject
{
    Q_OBJECT
    Q_PROPERTY(QString activeStyle READ activeStyle CONSTANT FINAL)
    Q_PROPERTY(Theme theme READ theme WRITE setTheme RESET resetTheme NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor primary READ primary WRITE setPrimary RESET resetPrimary NOTIFY primaryChanged FINAL)
    Q_PROPERTY(QColor primaryVariant READ primaryVariant WRITE setPrimaryVariant RESET resetPrimaryVariant NOTIFY primaryVariantChanged FINAL)
    Q_PROPERTY(QColor secondary READ secondary WRITE setSecondary RESET resetSecondary NOTIFY secondaryChanged FINAL)
    Q_PROPERTY(QColor secondaryVariant READ secondaryVariant WRITE setSecondaryVariant RESET resetSecondaryVariant NOTIFY secondaryVariantChanged FINAL)
    Q_PROPERTY(QColor background READ background WRITE setBackground RESET resetBackground NOTIFY backgroundChanged FINAL)
    Q_PROPERTY(QColor surface READ surface WRITE setSurface RESET resetSurface NOTIFY surfaceChanged FINAL)
    Q_PROPERTY(QColor error READ error WRITE setError RESET resetError NOTIFY errorChanged FINAL)
    Q_PROPERTY(QColor foreground READ foreground WRITE setForeground NOTIFY foregroundChanged FINAL)
    Q_PROPERTY(QColor foregroundOnPrimary READ foregroundOnPrimary WRITE setForegroundOnPrimary NOTIFY foregroundOnPrimaryChanged FINAL)
    Q_PROPERTY(QColor foregroundOnSecondary READ foregroundOnSecondary WRITE setForegroundOnSecondary NOTIFY foregroundOnSecondaryChanged FINAL)
    Q_PROPERTY(QColor foregroundOnBackground READ foregroundOnBackground WRITE setForegroundOnBackground NOTIFY foregroundOnBackgroundChanged FINAL)
    Q_PROPERTY(QColor foregroundOnSurface READ foregroundOnSurface WRITE setForegroundOnSurface NOTIFY foregroundOnSurfaceChanged FINAL)
    Q_PROPERTY(QColor foregroundOnError READ foregroundOnError WRITE setForegroundOnError NOTIFY foregroundOnErrorChanged FINAL)
    Q_PROPERTY(int elevation READ elevation WRITE setElevation RESET resetElevation NOTIFY elevationChanged FINAL)

public:
    enum Theme {
        Light,
        Dark,
        System
    };
    Q_ENUM(Theme)

    enum FontType {
        Headline1,
        Headline2,
        Headline3,
        Headline4,
        Headline5,
        Headline6,
        Subtitle1,
        Subtitle2,
        Body1,
        Body2,
        Button,
        Caption,
        Overline,
        Number1,
        Number2,
        Number3,
        Number4
    };
    Q_ENUM(FontType)

    explicit QwcxControlsFluidStyle(QObject *parent = nullptr);

    static QwcxControlsFluidStyle *qmlAttachedProperties(QObject *object);

    QString activeStyle() const;

    void setTheme(Theme theme);
    Theme theme() const;
    void inheritTheme(Theme theme);
    void propagateTheme();
    void resetTheme();

    void setPrimary(const QColor &primary);
    QColor primary() const;
    void inheritPrimary(const QColor &primary);
    void propagatePrimary();
    void resetPrimary();

    void setPrimaryVariant(const QColor &primaryVariant);
    QColor primaryVariant() const;
    void inheritPrimaryVariant(const QColor &primaryVariant);
    void propagatePrimaryVariant();
    void resetPrimaryVariant();

    void setSecondary(const QColor &secondary);
    QColor secondary() const;
    void inheritSecondary(const QColor &secondary);
    void propagateSecondary();
    void resetSecondary();

    void setSecondaryVariant(const QColor &secondaryVariant);
    QColor secondaryVariant() const;
    void inheritSecondaryVariant(const QColor &secondaryVariant);
    void propagateSecondaryVariant();
    void resetSecondaryVariant();

    void setBackground(const QColor &background);
    QColor background() const;
    void inheritBackground(const QColor &background);
    void propagateBackground();
    void resetBackground();

    void setSurface(const QColor &surface);
    QColor surface() const;
    void inheritSurface(const QColor &surface);
    void propagateSurface();
    void resetSurface();

    void setError(const QColor &error);
    QColor error() const;
    void inheritError(const QColor &error);
    void propagateError();
    void resetError();

    void setForeground(const QColor &foreground);
    QColor foreground() const;
    void resetForeground();

    void setForegroundOnPrimary(const QColor &foregroundOnPrimary);
    QColor foregroundOnPrimary() const;
    void inheritForegroundOnPrimary(const QColor &foregroundOnPrimary);
    void propagateForegroundOnPrimary();
    void resetForegroundOnPrimary();

    void setForegroundOnSecondary(const QColor &foregroundOnSecondary);
    QColor foregroundOnSecondary() const;
    void inheritForegroundOnSecondary(const QColor &foregroundOnSecondary);
    void propagateForegroundOnSecondary();
    void resetForegroundOnSecondary();

    void setForegroundOnBackground(const QColor &foregroundOnBackground);
    QColor foregroundOnBackground() const;
    void inheritForegroundOnBackground(const QColor &foregroundOnBackground);
    void propagateForegroundOnBackground();
    void resetForegroundOnBackground();

    void setForegroundOnSurface(const QColor &foregroundOnSurface);
    QColor foregroundOnSurface() const;
    void inheritForegroundOnSurface(const QColor &foregroundOnSurface);
    void propagateForegroundOnSurface();
    void resetForegroundOnSurface();

    void setForegroundOnError(const QColor &foregroundOnError);
    QColor foregroundOnError() const;
    void inheritForegroundOnError(const QColor &foregroundOnError);
    void propagateForegroundOnError();
    void resetForegroundOnError();

    void setElevation(int elevation);
    int elevation() const;
    void resetElevation();

    Q_INVOKABLE QFont font(FontType type) const;

Q_SIGNALS:
    void themeChanged();
    void primaryChanged();
    void primaryVariantChanged();
    void secondaryChanged();
    void secondaryVariantChanged();
    void backgroundChanged();
    void surfaceChanged();
    void errorChanged();
    void foregroundChanged();
    void foregroundOnPrimaryChanged();
    void foregroundOnSecondaryChanged();
    void foregroundOnBackgroundChanged();
    void foregroundOnSurfaceChanged();
    void foregroundOnErrorChanged();
    void elevationChanged();

protected:
    void attachedParentChange(QQuickAttachedObject *newParent, QQuickAttachedObject *oldParent) override;

private:
    void initializeActiveStyleAdapter();

private:
    // These reflect whether a color value was explicitly set on the specific
    // item that this attached style object represents.
    bool m_explicitTheme;
    bool m_explicitPrimary;
    bool m_explicitPrimaryVariant;
    bool m_explicitSecondary;
    bool m_explicitSecondaryVariant;
    bool m_explicitBackground;
    bool m_explicitSurface;
    bool m_explicitError;
    bool m_explicitForegroundOnPrimary;
    bool m_explicitForegroundOnSecondary;
    bool m_explicitForegroundOnBackground;
    bool m_explicitForegroundOnSurface;
    bool m_explicitForegroundOnError;

    // The actual values for this item, whether explicit, inherited or globally set.
    Theme m_theme;
    QColor m_primary;
    QColor m_primaryVariant;
    QColor m_secondary;
    QColor m_secondaryVariant;
    QColor m_background;
    QColor m_surface;
    QColor m_error;
    QColor m_foregroundOnPrimary;
    QColor m_foregroundOnSecondary;
    QColor m_foregroundOnBackground;
    QColor m_foregroundOnSurface;
    QColor m_foregroundOnError;
    int m_elevation;
};

QWCX_CONTROLS_END_NAMESPACE

QML_DECLARE_TYPEINFO(QWCX::Controls::QwcxControlsFluidStyle, QML_HAS_ATTACHED_PROPERTIES)

#endif // QWCX_CONTROLS_FLUID_QWCXCONTROLSFLUIDSTYLE_P_H
