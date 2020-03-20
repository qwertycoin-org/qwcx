#include <QtCore/QFile>
#include <QtQml/qqml.h>
#include <QtQml/QQmlComponent>
#include <QtQml/QQmlContext>
#include <QtQml/QQmlEngine>
#include <QtQuickControls2/QQuickStyle>
#include <QtQuickControls2/private/qquickstyle_p.h>
#include <QWCX/Controls/Fluid/qwcxcontrolsfluidstyle_p.h>

QWCX_CONTROLS_BEGIN_NAMESPACE

// If no value was inherited from a parent or explicitly set, the "global" values are used.
// The initial, default values of the globals are hard-coded here.
static QwcxControlsFluidStyle::Theme globalTheme = QwcxControlsFluidStyle::Theme::Light;
static uint globalPrimary = 0xFF6200EE;
static uint globalPrimaryVariant = 0xFF3700B3;
static uint globalSecondary = 0xFF03DAC6;
static uint globalSecondaryVariant = 0xFF018786;
static uint globalBackground = 0xFFFAFAFA;
static uint globalSurface = 0xFFFAFAFA;
static uint globalError = 0xFFB00020;
static uint globalForegroundOnPrimary = 0xFFFFFFFF;
static uint globalForegroundOnSecondary = 0xFF000000;
static uint globalForegroundOnBackground = 0xDD000000;
static uint globalForegroundOnSurface = 0xDD000000;
static uint globalForegroundOnError = 0xFFFFFFFF;

// The initial, default values of the globals (for dark theme) are hard-coded here.
static uint darkBackground = 0xFF303030;
static uint darkSurface = 0xFF303030;
static uint darkForegroundOnBackground = 0xFFFFFFFF;
static uint darkForegroundOnSurface = 0xFFFFFFFF;

QwcxControlsFluidStyle::QwcxControlsFluidStyle(QObject *parent)
    : QQuickAttachedObject(parent),
      m_explicitTheme(false),
      m_explicitPrimary(false),
      m_explicitPrimaryVariant(false),
      m_explicitSecondary(false),
      m_explicitSecondaryVariant(false),
      m_explicitBackground(false),
      m_explicitSurface(false),
      m_explicitError(false),
      m_explicitForegroundOnPrimary(false),
      m_explicitForegroundOnSecondary(false),
      m_explicitForegroundOnBackground(false),
      m_explicitForegroundOnSurface(false),
      m_explicitForegroundOnError(false),
      m_theme(QwcxControlsFluidStyle::Theme::Light),
      m_primary(QColor(globalPrimary)),
      m_primaryVariant(QColor(globalPrimaryVariant)),
      m_secondary(QColor(globalSecondary)),
      m_secondaryVariant(QColor(globalSecondaryVariant)),
      m_background(QColor(globalBackground)),
      m_surface(QColor(globalSurface)),
      m_error(QColor(globalError)),
      m_foregroundOnPrimary(QColor(globalForegroundOnPrimary)),
      m_foregroundOnSecondary(QColor(globalForegroundOnSecondary)),
      m_foregroundOnBackground(QColor(globalForegroundOnBackground)),
      m_foregroundOnSurface(QColor(globalForegroundOnSurface)),
      m_foregroundOnError(QColor(globalForegroundOnError)),
      m_elevation(0)
{
    initializeActiveStyleAdapter();
}

QwcxControlsFluidStyle *QwcxControlsFluidStyle::qmlAttachedProperties(QObject *object)
{
    return new QwcxControlsFluidStyle(object);
}

QString QwcxControlsFluidStyle::activeStyle() const
{
    return QQuickStyle::name();
}

void QwcxControlsFluidStyle::setTheme(QwcxControlsFluidStyle::Theme theme)
{
    m_explicitTheme = true;

    if (theme == System)
        theme = QQuickStylePrivate::isDarkSystemTheme() ? Dark : Light;

    if (m_theme == theme)
        return;

    m_theme = theme;
    propagateTheme();
    emit themeChanged();

    const bool isDark = (m_theme == QwcxControlsFluidStyle::Theme::Dark);
    // skipped: primary
    // skipped: primaryVariant
    // skipped: secondary
    // skipped: secondaryVariant
    if (!m_explicitBackground) {
        QColor color(isDark ? darkBackground : globalBackground);
        inheritBackground(color);
    }
    if (!m_explicitSurface) {
        QColor color(isDark ? darkSurface : globalSurface);
        inheritSurface(color);
    }
    // skipped: error
    // skipped: foregroundOnPrimary
    // skipped: foregroundOnSecondary
    if (!m_explicitForegroundOnBackground) {
        QColor color(isDark ? darkForegroundOnBackground : globalForegroundOnBackground);
        inheritForegroundOnBackground(color);
    }
    if (!m_explicitForegroundOnSurface) {
        QColor color(isDark ? darkForegroundOnSurface : globalForegroundOnSurface);
        inheritForegroundOnSurface(color);
    }
    // skipped: foregroundOnError
}

QwcxControlsFluidStyle::Theme QwcxControlsFluidStyle::theme() const
{
    return m_theme;
}

void QwcxControlsFluidStyle::inheritTheme(QwcxControlsFluidStyle::Theme theme)
{
    if (m_explicitTheme || m_theme == theme)
        return;

    m_theme = theme;
    propagateTheme();
    emit themeChanged();

    const bool isDark = (m_theme == QwcxControlsFluidStyle::Theme::Dark);
    // skipped: primary
    // skipped: primaryVariant
    // skipped: secondary
    // skipped: secondaryVariant
    if (!m_explicitBackground) {
        QColor color(isDark ? darkBackground : globalBackground);
        inheritBackground(color);
    }
    if (!m_explicitSurface) {
        QColor color(isDark ? darkSurface : globalSurface);
        inheritSurface(color);
    }
    // skipped: error
    // skipped: foregroundOnPrimary
    // skipped: foregroundOnSecondary
    if (!m_explicitForegroundOnBackground) {
        QColor color(isDark ? darkForegroundOnBackground : globalForegroundOnBackground);
        inheritForegroundOnBackground(color);
    }
    if (!m_explicitForegroundOnSurface) {
        QColor color(isDark ? darkForegroundOnSurface : globalForegroundOnSurface);
        inheritForegroundOnSurface(color);
    }
    // skipped: foregroundOnError
}

void QwcxControlsFluidStyle::propagateTheme()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritTheme(m_theme);
    }
}

void QwcxControlsFluidStyle::resetTheme()
{
    if (!m_explicitTheme)
        return;

    m_explicitTheme = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    inheritTheme(fluid ? fluid->theme() : globalTheme);
}

void QwcxControlsFluidStyle::setPrimary(const QColor &primary)
{
    m_explicitPrimary = true;

    if (m_primary == primary)
        return;

    m_primary = primary;
    propagatePrimary();
    emit primaryChanged();
}

QColor QwcxControlsFluidStyle::primary() const
{
    return m_primary;
}

void QwcxControlsFluidStyle::inheritPrimary(const QColor &primary)
{
    if (m_explicitPrimary || m_primary == primary)
        return;

    m_primary = primary;
    propagatePrimary();
    emit primaryChanged();
}

void QwcxControlsFluidStyle::propagatePrimary()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritPrimary(m_primary);
    }
}

void QwcxControlsFluidStyle::resetPrimary()
{
    if (!m_explicitPrimary)
        return;

    m_explicitPrimary = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    inheritPrimary(fluid ? fluid->m_primary : globalPrimary);
}

void QwcxControlsFluidStyle::setPrimaryVariant(const QColor &primaryVariant)
{
    m_explicitPrimaryVariant = true;

    if (m_primaryVariant == primaryVariant)
        return;

    m_primaryVariant = primaryVariant;
    propagatePrimaryVariant();
    emit primaryVariantChanged();
}

QColor QwcxControlsFluidStyle::primaryVariant() const
{
    return m_primaryVariant;
}

void QwcxControlsFluidStyle::inheritPrimaryVariant(const QColor &primaryVariant)
{
    if (m_explicitPrimaryVariant || m_primaryVariant == primaryVariant)
        return;

    m_primaryVariant = primaryVariant;
    propagatePrimaryVariant();
    emit primaryVariantChanged();
}

void QwcxControlsFluidStyle::propagatePrimaryVariant()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritPrimaryVariant(m_primaryVariant);
    }
}

void QwcxControlsFluidStyle::resetPrimaryVariant()
{
    if (!m_explicitPrimaryVariant)
        return;

    m_explicitPrimaryVariant = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    inheritPrimaryVariant(fluid ? fluid->m_primaryVariant : globalPrimaryVariant);
}

void QwcxControlsFluidStyle::setSecondary(const QColor &secondary)
{
    m_explicitSecondary = true;

    if (m_secondary == secondary)
        return;

    m_secondary = secondary;
    propagateSecondary();
    emit secondaryChanged();
}

QColor QwcxControlsFluidStyle::secondary() const
{
    return m_secondary;
}

void QwcxControlsFluidStyle::inheritSecondary(const QColor &secondary)
{
    if (m_explicitSecondary || m_secondary == secondary)
        return;

    m_secondary = secondary;
    propagateSecondary();
    emit secondaryChanged();
}

void QwcxControlsFluidStyle::propagateSecondary()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritSecondary(fluid->m_secondary);
    }
}

void QwcxControlsFluidStyle::resetSecondary()
{
    if (!m_explicitSecondary)
        return;

    m_explicitSecondary = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    inheritSecondary(fluid ? fluid->m_secondary : globalSecondary);
}

void QwcxControlsFluidStyle::setSecondaryVariant(const QColor &secondaryVariant)
{
    m_explicitSecondaryVariant = true;

    if (m_secondaryVariant == secondaryVariant)
        return;

    m_secondaryVariant = secondaryVariant;
    propagateSecondaryVariant();
    emit secondaryVariantChanged();
}

QColor QwcxControlsFluidStyle::secondaryVariant() const
{
    return m_secondaryVariant;
}

void QwcxControlsFluidStyle::inheritSecondaryVariant(const QColor &secondaryVariant)
{
    if (m_explicitSecondaryVariant || m_secondaryVariant == secondaryVariant)
        return;

    m_secondaryVariant = secondaryVariant;
    propagateSecondaryVariant();
    emit secondaryVariantChanged();
}

void QwcxControlsFluidStyle::propagateSecondaryVariant()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritSecondaryVariant(fluid->m_secondaryVariant);
    }
}

void QwcxControlsFluidStyle::resetSecondaryVariant()
{
    if (!m_explicitSecondaryVariant)
        return;

    m_explicitSecondaryVariant = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    inheritSecondaryVariant(fluid ? fluid->m_secondaryVariant : globalSecondaryVariant);
}

void QwcxControlsFluidStyle::setBackground(const QColor &background)
{
    m_explicitBackground = true;

    if (m_background == background)
        return;

    m_background = background;
    propagateBackground();
    emit backgroundChanged();
}

QColor QwcxControlsFluidStyle::background() const
{
    return m_background;
}

void QwcxControlsFluidStyle::inheritBackground(const QColor &background)
{
    if (m_explicitBackground || m_background == background)
        return;

    m_background = background;
    propagateBackground();
    emit backgroundChanged();
}

void QwcxControlsFluidStyle::propagateBackground()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritBackground(fluid->m_background);
    }
}

void QwcxControlsFluidStyle::resetBackground()
{
    if (!m_explicitBackground)
        return;

    m_explicitBackground = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    if (fluid) {
        inheritBackground(fluid->m_background);
    } else {
        inheritSurface(m_theme == Dark ? darkBackground : globalBackground);
    }
}

void QwcxControlsFluidStyle::setSurface(const QColor &surface)
{
    m_explicitSurface = true;

    if (m_surface == surface)
        return;

    m_surface = surface;
    propagateSurface();
    emit surfaceChanged();
}

QColor QwcxControlsFluidStyle::surface() const
{
    return m_surface;
}

void QwcxControlsFluidStyle::inheritSurface(const QColor &surface)
{
    if (m_explicitSurface || m_surface == surface)
        return;

    m_surface = surface;
    propagateSurface();
    emit surfaceChanged();
}

void QwcxControlsFluidStyle::propagateSurface()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritSurface(fluid->m_surface);
    }
}

void QwcxControlsFluidStyle::resetSurface()
{
    if (!m_explicitSurface)
        return;

    m_explicitSurface = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    if (fluid) {
        inheritSurface(fluid->m_surface);
    } else {
        inheritSurface(m_theme == Dark ? darkSurface : globalSurface);
    }
}

void QwcxControlsFluidStyle::setError(const QColor &error)
{
    m_explicitError = true;

    if (m_error == error)
        return;

    m_error = error;
    propagateError();
    emit errorChanged();
}

QColor QwcxControlsFluidStyle::error() const
{
    return m_error;
}

void QwcxControlsFluidStyle::inheritError(const QColor &error)
{
    if (m_explicitError || m_error == error)
        return;

    m_error = error;
    propagateError();
    emit errorChanged();
}

void QwcxControlsFluidStyle::propagateError()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritError(fluid->m_error);
    }
}

void QwcxControlsFluidStyle::resetError()
{
    if (!m_explicitError)
        return;

    m_explicitError = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    inheritSurface(fluid ? fluid->m_error : globalError);
}

void QwcxControlsFluidStyle::setForeground(const QColor &foreground)
{
    setForegroundOnBackground(foreground);
}

QColor QwcxControlsFluidStyle::foreground() const
{
    return foregroundOnBackground();
}

void QwcxControlsFluidStyle::resetForeground()
{
    resetForegroundOnBackground();
}

void QwcxControlsFluidStyle::setForegroundOnPrimary(const QColor &foregroundOnPrimary)
{
    m_explicitForegroundOnPrimary = true;

    if (m_foregroundOnPrimary == foregroundOnPrimary)
        return;

    m_foregroundOnPrimary = foregroundOnPrimary;
    propagateForegroundOnPrimary();
    emit foregroundOnPrimaryChanged();
}

QColor QwcxControlsFluidStyle::foregroundOnPrimary() const
{
    return m_foregroundOnPrimary;
}

void QwcxControlsFluidStyle::inheritForegroundOnPrimary(const QColor &foregroundOnPrimary)
{
    if (m_explicitForegroundOnPrimary || m_foregroundOnPrimary == foregroundOnPrimary)
        return;

    m_foregroundOnPrimary = foregroundOnPrimary;
    propagateForegroundOnPrimary();
    emit foregroundOnPrimaryChanged();
}

void QwcxControlsFluidStyle::propagateForegroundOnPrimary()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritForegroundOnPrimary(fluid->m_foregroundOnPrimary);
    }
}

void QwcxControlsFluidStyle::resetForegroundOnPrimary()
{
    if (!m_explicitForegroundOnPrimary)
        return;

    m_explicitForegroundOnPrimary = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    inheritForegroundOnPrimary(fluid ? fluid->m_foregroundOnPrimary : globalForegroundOnPrimary);
}

void QwcxControlsFluidStyle::setForegroundOnSecondary(const QColor &foregroundOnSecondary)
{
    m_explicitForegroundOnSecondary = true;

    if (m_foregroundOnSecondary == foregroundOnSecondary)
        return;

    m_foregroundOnSecondary = foregroundOnSecondary;
    propagateForegroundOnSecondary();
    emit foregroundOnSecondaryChanged();
}

QColor QwcxControlsFluidStyle::foregroundOnSecondary() const
{
    return m_foregroundOnSecondary;
}

void QwcxControlsFluidStyle::inheritForegroundOnSecondary(const QColor &foregroundOnSecondary)
{
    if (m_explicitForegroundOnSecondary || m_foregroundOnSecondary == foregroundOnSecondary)
        return;

    m_foregroundOnSecondary = foregroundOnSecondary;
    propagateForegroundOnSecondary();
    emit foregroundOnSecondaryChanged();
}

void QwcxControlsFluidStyle::propagateForegroundOnSecondary()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritForegroundOnSecondary(fluid->m_foregroundOnSecondary);
    }
}

void QwcxControlsFluidStyle::resetForegroundOnSecondary()
{
    if (!m_explicitForegroundOnSecondary)
        return;

    m_explicitForegroundOnSecondary = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    QColor color(fluid ? fluid->m_foregroundOnSecondary : globalForegroundOnSecondary);
    inheritForegroundOnSecondary(color);
}

void QwcxControlsFluidStyle::setForegroundOnBackground(const QColor &foregroundOnBackground)
{
    m_explicitForegroundOnBackground = true;

    if (m_foregroundOnBackground == foregroundOnBackground)
        return;

    m_foregroundOnBackground = foregroundOnBackground;
    propagateForegroundOnBackground();
    emit foregroundOnBackgroundChanged();
    emit foregroundChanged();
}

QColor QwcxControlsFluidStyle::foregroundOnBackground() const
{
    return m_foregroundOnBackground;
}

void QwcxControlsFluidStyle::inheritForegroundOnBackground(const QColor &foregroundOnBackground)
{
    if (m_explicitForegroundOnBackground || m_foregroundOnBackground == foregroundOnBackground)
        return;

    m_foregroundOnBackground = foregroundOnBackground;
    propagateForegroundOnBackground();
    emit foregroundOnBackgroundChanged();
    emit foregroundChanged();
}

void QwcxControlsFluidStyle::propagateForegroundOnBackground()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritForegroundOnBackground(fluid->m_foregroundOnBackground);
    }
}

void QwcxControlsFluidStyle::resetForegroundOnBackground()
{
    if (!m_explicitForegroundOnBackground)
        return;

    m_explicitForegroundOnBackground = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    if (fluid) {
        inheritForegroundOnBackground(fluid->m_foregroundOnBackground);
    } else {
        QColor color(m_theme == Dark ? darkForegroundOnBackground : globalForegroundOnBackground);
        inheritForegroundOnBackground(color);
    }
}

void QwcxControlsFluidStyle::setForegroundOnSurface(const QColor &foregroundOnSurface)
{
    m_explicitForegroundOnSurface = true;

    if (m_foregroundOnSurface == foregroundOnSurface)
        return;

    m_foregroundOnSurface = foregroundOnSurface;
    propagateForegroundOnSurface();
    emit foregroundOnSurfaceChanged();
}

QColor QwcxControlsFluidStyle::foregroundOnSurface() const
{
    return m_foregroundOnSurface;
}

void QwcxControlsFluidStyle::inheritForegroundOnSurface(const QColor &foregroundOnSurface)
{
    if (m_explicitForegroundOnSurface || m_foregroundOnSurface == foregroundOnSurface)
        return;

    m_foregroundOnSurface = foregroundOnSurface;
    propagateForegroundOnSurface();
    emit foregroundOnSurfaceChanged();
}

void QwcxControlsFluidStyle::propagateForegroundOnSurface()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritForegroundOnSurface(fluid->m_foregroundOnSurface);
    }
}

void QwcxControlsFluidStyle::resetForegroundOnSurface()
{
    if (!m_explicitForegroundOnSurface)
        return;

    m_explicitForegroundOnSurface = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    if (fluid) {
        inheritForegroundOnSurface(fluid->m_foregroundOnSurface);
    } else {
        QColor color(m_theme == Dark ? darkForegroundOnSurface : globalForegroundOnSurface);
        inheritForegroundOnSurface(color);
    }
}

void QwcxControlsFluidStyle::setForegroundOnError(const QColor &foregroundOnError)
{
    m_explicitForegroundOnError = true;

    if (m_foregroundOnError == foregroundOnError)
        return;

    m_foregroundOnError = foregroundOnError;
    propagateForegroundOnError();
    emit foregroundOnErrorChanged();
}

QColor QwcxControlsFluidStyle::foregroundOnError() const
{
    return m_foregroundOnError;
}

void QwcxControlsFluidStyle::inheritForegroundOnError(const QColor &foregroundOnError)
{
    if (m_explicitForegroundOnError || m_foregroundOnError == foregroundOnError)
        return;

    m_foregroundOnError = foregroundOnError;
    propagateForegroundOnError();
    emit foregroundOnErrorChanged();
}

void QwcxControlsFluidStyle::propagateForegroundOnError()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedObject *child : styles) {
        QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(child);
        if (fluid)
            fluid->inheritForegroundOnError(fluid->m_foregroundOnError);
    }
}

void QwcxControlsFluidStyle::resetForegroundOnError()
{
    if (!m_explicitForegroundOnError)
        return;

    m_explicitForegroundOnError = false;
    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(attachedParent());
    inheritForegroundOnError(fluid ? fluid->m_foregroundOnError : globalForegroundOnError);
}

void QwcxControlsFluidStyle::setElevation(int elevation)
{
    elevation = elevation < 0 ? 0 : elevation;

    if (m_elevation == elevation)
        return;

    m_elevation = elevation;
    emit elevationChanged();
}

int QwcxControlsFluidStyle::elevation() const
{
    return m_elevation;
}

void QwcxControlsFluidStyle::resetElevation()
{
    setElevation(0);
}

QFont QwcxControlsFluidStyle::font(QwcxControlsFluidStyle::FontType type) const
{
    QFont font;

    switch (type) {
    case Headline1:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Light);
        font.setPixelSize(82);
        font.setLetterSpacing(QFont::AbsoluteSpacing, -1.5);
        break;
    case Headline2:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Light);
        font.setPixelSize(51);
        font.setLetterSpacing(QFont::AbsoluteSpacing, -0.5);
        break;
    case Headline3:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(41);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.0);
        break;
    case Headline4:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(29);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.25);
        break;
    case Headline5:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(20);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.0);
        break;
    case Headline6:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Medium);
        font.setPixelSize(17);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.15);
        break;
    case Subtitle1:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(14);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.15);
        break;
    case Subtitle2:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Medium);
        font.setPixelSize(12);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.1);
        break;
    case Body1:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(14);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.5);
        break;
    case Body2:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(12);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.25);
        break;
    case Button:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Medium);
        font.setPixelSize(13);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 1.25);
        break;
    case Caption:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(10);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.4);
        break;
    case Overline:
        font.setFamily(QStringLiteral("Roboto Condensed"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(9);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 1.5);
        font.setCapitalization(QFont::AllUppercase);
        break;
    case Number1:
        font.setFamily(QStringLiteral("Eczar"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(33);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.25);
        break;
    case Number2:
        font.setFamily(QStringLiteral("Eczar"));
        font.setWeight(QFont::Medium);
        font.setPixelSize(19);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.15);
        break;
    case Number3:
        font.setFamily(QStringLiteral("Eczar"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(15);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.15);
        break;
    case Number4:
        font.setFamily(QStringLiteral("Eczar"));
        font.setWeight(QFont::Normal);
        font.setPixelSize(13);
        font.setLetterSpacing(QFont::AbsoluteSpacing, 0.1);
        break;
    default:
        // TODO: Use default system font.
        break;
    }

    return font;
}

void QwcxControlsFluidStyle::attachedParentChange(QQuickAttachedObject *newParent,
                                                  QQuickAttachedObject *oldParent)
{
    Q_UNUSED(oldParent);

    QwcxControlsFluidStyle *fluid = qobject_cast<QwcxControlsFluidStyle *>(newParent);
    if (fluid) {
        inheritTheme(fluid->theme());
        inheritPrimary(fluid->m_primary);
        inheritPrimaryVariant(fluid->m_primaryVariant);
        inheritSecondary(fluid->m_secondary);
        inheritSecondaryVariant(fluid->m_secondaryVariant);
        inheritBackground(fluid->m_background);
        inheritSurface(fluid->m_surface);
        inheritError(fluid->m_error);
        inheritForegroundOnPrimary(fluid->m_foregroundOnPrimary);
        inheritForegroundOnSecondary(fluid->m_foregroundOnSecondary);
        inheritForegroundOnBackground(fluid->m_foregroundOnBackground);
        inheritForegroundOnSurface(fluid->m_foregroundOnSurface);
        inheritForegroundOnError(fluid->m_foregroundOnError);
    }
}

void QwcxControlsFluidStyle::initializeActiveStyleAdapter()
{
    const QString filePrefix = QStringLiteral(":/lib/QWCX/Controls/Fluid/internal");
    const QString fileName = QStringLiteral("%1StyleAdapter.qml").arg(activeStyle());
    const QString filePath = QStringLiteral("%1/%2").arg(filePrefix, fileName);
    const QUrl fileUrl = QUrl(QStringLiteral("qrc%1").arg(filePath));
    if (!QFile::exists(filePath) || !fileUrl.isValid())
        return;

    QQmlContext *context = QtQml::qmlContext(parent());
    if (!context)
        return;

    QQmlComponent component(context->engine(), fileUrl, QQmlComponent::PreferSynchronous, this);
    if (component.isReady()) {
        QVariantMap initialProperties;
        initialProperties[QStringLiteral("target")] = QVariant::fromValue(parent());
        initialProperties[QStringLiteral("fluid")] = QVariant::fromValue(this);

        QObject *item = component.createWithInitialProperties(initialProperties, context);
        item->setParent(this);
        QQmlEngine::setObjectOwnership(item, QQmlEngine::CppOwnership);
    }
}

QWCX_CONTROLS_END_NAMESPACE
