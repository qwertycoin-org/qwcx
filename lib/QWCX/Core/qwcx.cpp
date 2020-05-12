#include <QtQml/QJSEngine>
#include <QtQml/QQmlEngine>
#include <QWCX/Core/qwcx.h>

QWCX_CORE_BEGIN_NAMESPACE

static Qwcx *m_instance = nullptr;

Qwcx::Qwcx(QObject *parent)
    : QObject(parent)
{
}

Qwcx::~Qwcx()
{
}

Qwcx *Qwcx::instance()
{
    return m_instance ? m_instance : new Qwcx(nullptr);
}

Qwcx *Qwcx::i()
{
    return Qwcx::instance();
}

void Qwcx::destroyInstance()
{
    if (!m_instance)
        return;

    delete m_instance;
    m_instance = nullptr;
}

QObject *Qwcx::qmlInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(scriptEngine)

    Qwcx *object = Qwcx::instance();

    engine->setObjectOwnership(object, QQmlEngine::ObjectOwnership::CppOwnership);

    return object;
}

QWCX_CORE_END_NAMESPACE

#include "moc_qwcx.cpp"
