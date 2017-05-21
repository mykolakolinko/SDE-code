#include<iostream>
#include<fstream>
#include<thread>
#include<future>
#include<random>
#include<chrono> 

struct ProcessPair{
	std::vector<double> SDE;
	std::vector<double> Explicit;
};

struct Params{
	double mu0, mu1, sigma0, sigma1;
};

std::vector<double> GenerateIncrements(int count)//, std::normal_distribution<> & dist, std::mt19937 & gen)
{
	std::minstd_rand gen(std::hash<std::thread::id>{}(std::this_thread::get_id())
	 * std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch()).count());
	std::normal_distribution<> dist(0, 1);
	auto increments = std::vector<double>(count);
	double prev = 0;
	for (int i = 0; i < count; i++)
	{
		increments[i] = dist(gen);
	}
	return increments;
}

ProcessPair GenerateProcesses(std::vector<double> increments, std::function<double(double, double)> stepSDE, std::function<std::vector<double>(std::vector<double>, double)> getExplicit, double start)
{
	ProcessPair pair;
	int count = increments.size();
	pair.SDE = std::vector<double>(count + 1);
	pair.SDE[0] = start;

	for (int i = 0; i < count; i++)
	{
		pair.SDE[i + 1] = stepSDE(pair.SDE[i], increments[i]);
	}

	pair.Explicit = getExplicit(increments, start);

	return pair;
}

int main()
{
	std::random_device rd;
    std::mt19937 gen(rd());
	std::normal_distribution<> dist(0, 1);

	Params par = {1, 1, 1, 1};
	const int handlesCount = 10000;

	int x = 0;
	std::cin >> x;
	auto stepSDE = [&x, &par](double previous, double increment) -> double 
	{
		return previous + (par.mu0 + par.mu1 * previous) / x + (par.sigma0 + par.sigma1 * previous) * increment / std::sqrt(x);
	};
	auto getExplicit = [&x, &par](std::vector<double> increments, double start) -> std::vector<double> 
	{
		int count = increments.size();
		auto res = * new std::vector<double>(count + 1);
		double multiplier = 1;
		double addend = start;
		res[0] = start;
		for (int i = 0; i < count; i++)
		{
			addend += (par.mu0 - par.sigma0 * par.sigma1) / multiplier / x + par.sigma0 / multiplier * increments[i] / std::sqrt(x);
			multiplier *= std::exp((par.mu1 - std::pow(par.sigma1, 2) / 2) / x + par.sigma1 * increments[i] / std::sqrt(x));
			res[i + 1] = multiplier * addend;
		}
		return res;
	};

	long long start = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch()).count();
	auto handles = std::vector<std::future<ProcessPair>>(handlesCount);
	for (int i = 0; i < handlesCount; i++)
	{
		handles[i] = std::async(std::launch::deferred, [&]() -> ProcessPair{
			return GenerateProcesses(GenerateIncrements(x), stepSDE, getExplicit, 1);
			//return GenerateProcesses(GenerateIncrements(x, dist, gen), stepSDE, getExplicit, 1);
		});
	}
	std::ofstream myfile ("./out.txt");
	for (int i = 0; i < handlesCount; i++)
	{
		auto res = handles[i].get();
		double max = 0;
		for (int j = 0; j < x + 1; j++)
		{
			max = std::abs(res.SDE[j] - res.Explicit[j]) > max ? std::abs(res.SDE[j] - res.Explicit[j]) : max;
			//myfile << res.SDE[j] << "," << res.Explicit[j] << "," << i << "\n";
		}
		//myfile << i << "," << max << "\n";
	}
	myfile.close();
	
	std::cout << "elapsed " << std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now().time_since_epoch()).count() - start << " milliseconds\n";
}