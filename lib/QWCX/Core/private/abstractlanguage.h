#pragma once

#include <QWCX/Global/constants.h>

QWCX_CORE_BEGIN_NAMESPACE

class AbstractLanguage
{
public:
    explicit AbstractLanguage() = default;
    virtual ~AbstractLanguage() = default;

    virtual std::string locale() const = 0;
    virtual std::vector<std::string> words() const = 0;
};

QWCX_CORE_END_NAMESPACE
